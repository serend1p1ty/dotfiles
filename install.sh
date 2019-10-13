#!/usr/bin/env bash

############################ SETUP PARAMETERS
appName='dotfiles'
[ -z "$repoURL" ] && repoURL='https://github.com/ppnman/dotfiles.git'

############################ SETUP FUNCTIONS
doBackup()
{
    if [ -e "$1" ]; then
        echo ">>> Trying to back up $1."
        today=`date +%Y%m%d_%s`
        [ -e "$1" ] && [ ! -L "$1" ] && mv -v "$1" "$1.$today";
    fi
}

cloneRepo()
{
    echo ">>> Trying to clone $appName."
    git clone "$repoURL"
    echo ">>> Done."
}

installNeovim()
{
    echo ">>> Trying to install nvim."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    echo ">>> Done."
}

installVimPlugins()
{
    echo ">>> Trying to install essential packages for ycm."
    sudo apt install -y build-essential cmake python3-dev
    echo ">>> Done."

    echo ">>> Trying to install python3.7."
    sudo apt-get install -y python-dev python-setuptools python-pip python-smbus build-essential \
                            libncursesw5-dev libgdbm-dev libc6-dev zlib1g-dev libsqlite3-dev tk-dev \
                            libssl-dev openssl libffi-dev
    wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
    tar zxvf Python-3.7.3.tgz
    cd Python-3.7.3
    ./configure --with-ssl
    make
    sudo make install
    cd ..
    sudo rm -rf Python-3.7.3 Python-3.7.3.tgz
    sudo ln -sf /usr/local/bin/python3.7 /usr/local/bin/python3
    sudo ln -sf /usr/local/bin/pip3.7 /usr/local/bin/pip3
    echo ">>> Done."

    echo ">>> Trying to install python3 module for nvim."
    pip3 install neovim --user
    echo ">>> Done."

    echo ">>> Trying to install nodejs for coc."
    sudo apt install -y nodejs nodejs-legacy npm
    sudo npm config set registry https://registry.npm.taobao.org
    sudo npm install -g n
    sudo n stable
    sudo npm install -g neovim
    echo ">>> Done."

    nvim "+PlugInstall" \
         "+qall"
}

setupNeovim()
{
    read -p ">>> Have you ever installed Neovim in your computer? (y/n)" ans
    if [ "$ans" == "n" ]; then
        installNeovim
    fi

    doBackup "$HOME/.config/nvim"
    mkdir -p "$HOME"/.config/nvim
    cp -r "$appName"/vim/* "$HOME"/.config/nvim

    installVimPlugins

    echo ">>> Thanks for installing my vim!"
}

installZshPlugins()
{
    echo ">>> Trying to install zsh-theme."
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    echo ">>> Done."

    echo ">>> Trying to install nerd-font."
    sudo mkdir -p /usr/share/fonts/custom
    sudo mv "$appName"/font/Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ Mono.ttf /usr/share/fonts/custom
    sudo chmod 744 /usr/share/fonts/custom/Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ Mono.ttf
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    rm -f fonts.dir fonts.scale
    echo ">>> Done."

    echo ">>> Trying to install zsh-plugin: autojump."
    sudo apt install -y autojump
    echo ">>> Done."

    echo ">>> Trying to install zsh-plugin: autosuggestions."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo ">>> Done."

    echo ">>> Trying to install zsh-plugin: syntax-highlighting."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo ">>> Done."

    echo ">>> Trying to install fuzzy finder."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    echo ">>> Done."

    echo ">>> Trying to install fd."
    wget -c https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb
    sudo dpkg -i fd_7.3.0_amd64.deb
    rm fd_7.3.0_amd64.deb
    echo ">>> Done."
}

setupZsh()
{
    read -p ">>> Have you ever installed zsh in your computer? (y/n)" ans
    if [ "$ans" == "n" ]; then
        echo ">>> Trying to install zsh."
        sudo apt install -y zsh

        # Switch the shell to zsh
        chsh -s /bin/zsh

        read -p ">>> Your computer is going to be rebooted to validate zsh. Would you want to restart it by yourself? (y/n)" ans
        if [ "$ans" == "n" ]; then
            reboot
        else
            echo ">>> Don't forget to restart your computer, and continue to complete the rest part of installation."
        fi
    fi

    read -p ">>> Have you ever installed oh-my-zsh in your computer? (y/n)" ans
    if [ "$ans" == "n" ]; then
        echo ">>> Trying to install oh-my-zsh."
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        echo ">>> Done."
    fi

    doBackup "$HOME/.zshrc"
    cp "$appName"/zshrc "$HOME"/.zshrc

    installZshPlugins

    echo ">>> Thanks for installing my zsh!"
}

installTmux()
{
    # step1: install some essential softwares.
    sudo apt install -y automake build-essential pkg-config \
                        libevent-dev libncurses5-dev

    # step2: download tmux2.8 source code.
    git clone https://github.com/tmux/tmux.git
    cd tmux
    git checkout 01918cb

    # step3: compile and install.
    sh autogen.sh
    ./configure
    make && sudo make install

    # step4: remove tmux folder.
    cd ..
    rm -rf tmux
}

enableItalic()
{
    # create a new type of terminal named "tmux-256color"
    echo "tmux-256color|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color," >> tmux-256color.terminfo

    # install tmux-256color
    tic -x tmux-256color.terminfo

    # remove
    rm tmux-256color.terminfo
}

setupTmux()
{
    installTmux

    doBackup "$HOME/.tmux.conf"
    cp "$appName"/tmux.conf "$HOME"/.tmux.conf

    enableItalic

    echo ">>> Thanks for installing my tmux!"
}

############################ MAIN()
echo ">>> Welcome to $appName!"

if [ -z "$HOME" ]; then
    echo ">>> HOME environmental variable is required."
    exit 1
fi

if [ ! -e "./$appName" ]; then
    echo ">>> Trying to install git."
    sudo apt install -y git
    echo ">>> Done."

    cloneRepo
fi

read -p ">>> Do you want to use my zsh? (y/n)" ans
if [ "$ans" == "y" ]; then
    echo ">>> Zsh installation will begin......"
    setupZsh
fi

read -p ">>> Do you want to use my tmux? (y/n)" ans
if [ "$ans" == "y" ]; then
    echo ">>> Tmux installation will begin......"
    setupTmux
fi

read -p ">>> Do you want to use my vim? (y/n)" ans
if [ "$ans" == "y" ]; then
    echo ">>> Vim installation will begin......"
    setupNeovim
fi

read -p ">>> Do you want to use my gitconfig? (y/n)" ans
if [ "$ans" == "y" ]; then
    cp "$appName"/gitconfig ~/.gitconfig
fi

rm -rf "$appName"
rm install.sh

echo ">>> Thanks for installing $appName, enjoy it!"
