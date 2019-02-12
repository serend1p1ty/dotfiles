#!/usr/bin/env bash

############################  SETUP PARAMETERS
app_name='code-env'
[ -z "$repo_url" ] && repo_url='https://github.com/ppnman/code-env.git'

############################  BASIC SETUP TOOLS
msg() 
{
    printf '>>> %b\n' "$1" >&2
}

success_or_error() 
{
    if [ "$?" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}"
    else
        msg "\33[31m[✘]\33[0m ${2}"
    fi
}

program_exists() 
{
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() 
{
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        msg "\33[31m[✘]\33[0m You must have '$1' installed to continue."
        exit 1
    fi
}

############################ SETUP FUNCTIONS
do_backup() 
{
    if [ -e "$1" ]; then
        msg "Attempting to back up $1."
        today=`date +%Y%m%d_%s`
        [ -e "$1" ] && [ ! -L "$1" ] && mv -v "$1" "$1.$today";
        success_or_error "$1 has been backed up." \
                         "Failed to back up $1."
    fi
}

clone_repo() 
{
    msg "Trying to clone $app_name."
    git clone "$repo_url"
    success_or_error "Successfully cloned $app_name." \
                     "Failed to cloned $app_name"
}

install_vim8_from_source()
{
    # step0: remove original vim.
    sudo apt purge -y vim vim-runtime vim-gnome vim-common vim-tiny vim-gui-common

    # step1: install some essential softwares.
    sudo apt install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev
    
    # step2: download source code.
    git clone https://github.com/vim/vim.git
    cd vim
    
    # step3: configurate cmake.
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-python3interp=yes \
                --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --enable-gui=gtk2 \
                --enable-cscope \
                --prefix=/usr/local \
                --enable-fail-if-missing

    # step4: compile and install.
    make && sudo make install
    success_or_error "Successfully installed vim8." \
                     "Failed to install vim8."
    
    # step5: remove vim folder.
    cd ..
    rm -rf vim
}

setup_vim_plug() 
{
    local system_shell="$SHELL"
    export SHELL='/bin/sh'

    vim "+PlugInstall" \
        "+qall"
    
    success_or_error "Successfully installed plugins with vim-plug." \
                     "Failed to install plugins with vim-plug."

    export SHELL="$system_shell"
}

setup_vim()
{
    read -p ">>> Have you ever installed vim8 in your computer? (y/n)" ans
    if [ "$ans" == "n" ]; then
        msg "I will install vim8 from source code."
        install_vim8_from_source
    fi

    do_backup "$HOME/.vim"
    do_backup "$HOME/.vimrc"
    cp "$app_name"/vimrc "$HOME"/.vimrc
    mkdir -p "$HOME"/.vim
    cp -r "$app_name"/autoload "$HOME"/.vim

    setup_vim_plug

    msg "Thanks for installing my vim!"
}

setup_zsh_plug()
{
    msg "Trying to install zsh-plugin: autojump."
    sudo apt install -y autojump
    success_or_error "Successfully installed autojump." \
                     "Failed to install autojump."

    msg "Trying to install zsh-plugin: autosuggestions."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    success_or_error "Successfully installed autosuggestions." \
                     "Failed to install autosuggestions."

    msg "Trying to install zsh-plugin: syntax-highlighting."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    success_or_error "Successfully installed syntax-highlighting." \
                     "Failed to install syntax-highlighting."
}

setup_zsh()
{
    read -p ">>> Please tell me which part of zsh you want to install? (1/2)" part

    if [ "$part" == "1" ]; then
        msg "You are processing the first part of installation."

        msg "Trying to install zsh."
        sudo apt install -y zsh
        success_or_error "Successfully installed zsh." \
                         "Failed to install zsh."

        # Switch the shell to zsh
        chsh -s /bin/zsh

        read -p ">>> Please restart your computer to validate zsh. Would you want to restart it by yourself? (y/n)" ans
        if [ "$ans" == "n" ]; then
            reboot
        else
            msg "Don't forget to restart your computer, and continue to complete the second part of installation."
        fi
    else
        msg "You are processing the second part of installation."

        msg "Trying to install oh-my-zsh."
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        success_or_error "Successfully installed oh-my-zsh." \
                         "Failed to install oh-my-zsh."

        do_backup "$HOME/.zshrc"
        cp "$app_name"/zshrc "$HOME"/.zshrc

        msg "Trying to install zsh-theme."
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
        success_or_error "Successfully installed zsh-theme." \
                         "Failed to install zsh-theme."
 
        msg "Trying to install powerline fonts."
        sudo apt install -y fonts-powerline
        success_or_error "Successfully installed powerline fonts." \
                         "Failed to install powerline fonts."

        setup_zsh_plug

        msg "Trying to install fuzzy finder."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
        success_or_error "Successfully installed fuzzy finder." \
                         "Failed to install fuzzy finder."

        msg "Thanks for installing my zsh!"
    fi
}

install_tmux_from_source()
{
    # step1: install some essential softwares.
    sudo apt install -y automake build-essential pkg-config \
    libevent-dev libncurses5-dev
 
    # step2: download source code.
    git clone https://github.com/tmux/tmux.git
    cd tmux
 
    # step3: compile and install.
    sh autogen.sh
    ./configure
    make && sudo make install
    success_or_error "Successfully installed tmux from source code." \
                     "Failed to install tmux from source code."
 
    # step4: remove tmux folder.
    cd ..
    rm -rf tmux
}

setup_tmux()
{
    install_tmux_from_source

    do_backup "$HOME/.tmux.conf"
    cp "$app_name"/tmux.conf "$HOME"/.tmux.conf

    msg "Thanks for installing my tmux!"
}

############################ MAIN()
msg "Welcome to $app_name, I will guide you through the installation."

program_must_exist "git"

if [ -z "$HOME" ]; then
    msg "\33[31m[✘]\33[0m Must have HOME environmental variable."
    exit 1
fi

if [ ! -e "./$app_name" ]; then
    clone_repo
fi

read -p ">>> Do you want to use my zsh? (y/n)" ans
if [ "$ans" == "y" ]; then
    msg "Zsh installation will begin......"
    setup_zsh
fi

read -p ">>> Do you want to use my tmux? (y/n)" ans
if [ "$ans" == "y" ]; then
    msg "Tmux installation will begin......"
    setup_tmux
fi

read -p ">>> Do you want to use my vim? (y/n)" ans
if [ "$ans" == "y" ]; then
    msg "Vim installation will begin......"
    setup_vim
fi

rm -rf "$app_name"

msg "Thanks for installing $app_name, enjoy it!"
