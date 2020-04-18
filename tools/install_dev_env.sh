#!/usr/bin/env bash

############################ SETUP PARAMETERS
appName='dotfiles'
[ -z "$repoURL" ] && repoURL='https://github.com/520Chris/dotfiles.git'

############################ SETUP FUNCTIONS
print()
{
    echo -e ">>> \e[1;33m$1\e[0m"
}

doBackup()
{
    if [ -e "$1" ]; then
        print "Trying to back up $1."
        today=`date +%Y%m%d_%s`
        [ -e "$1" ] && [ ! -L "$1" ] && mv -v "$1" "$1.$today";
    fi
}

cloneRepo()
{
    print "Trying to clone $appName."
    git clone "$repoURL"
    print "Done."
}

installNeovim()
{
    print "Trying to install nvim."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
    print "Done."
}

installVimPlugins()
{
    # print "Trying to install essential packages for ycm."
    # sudo apt install -y build-essential cmake python3-dev
    # print "Done."

    print "Trying to install python3 module for nvim."
    sudo apt install -y python3-pip
    pip3 install neovim --user
    print "Done."

    print "Trying to install nodejs for coc."
    sudo apt install -y nodejs nodejs-legacy npm
    sudo npm config set registry https://registry.npm.taobao.org
    sudo npm install -g n
    sudo n stable
    sudo npm install -g neovim
    print "Done."

    print "Trying to install bash-language-server for coc."
    sudo npm i -g bash-language-server
    print "Done."

    nvim "+PlugInstall" \
         "+qall"
}

setupNeovim()
{
    print "Have you ever installed Neovim in your computer? (y/n)"
    read ans
    if [ "$ans" == "n" ]; then
        installNeovim
    fi

    doBackup "$HOME/.config/nvim"
    mkdir -p "$HOME"/.config/nvim
    cp -r "$appName"/vim/* "$HOME"/.config/nvim

    installVimPlugins

    print "Thanks for installing my vim!"
}

installZshPlugins()
{
    print "Trying to install zsh-theme."
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k --depth=1
    print "Done."

    print "Trying to install nerd-font."
    sudo mkdir -p /usr/share/fonts/custom
    sudo mv "$appName"/font/patched/Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ Mono.ttf /usr/share/fonts/custom
    sudo mv "$appName"/font/patched/SFMono\ Regular\ Nerd\ Font\ Complete\ Mono.otf /usr/share/fonts/custom
    sudo mv "$appName"/font/patched/SFMono\ RegularItalic\ Nerd\ Font\ Complete\ Mono.otf /usr/share/fonts/custom
    sudo chmod 744 /usr/share/fonts/custom/Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ Mono.ttf
    sudo chmod 744 /usr/share/fonts/custom/SFMono\ Regular\ Nerd\ Font\ Complete\ Mono.otf
    sudo chmod 744 /usr/share/fonts/custom/SFMono\ RegularItalic\ Nerd\ Font\ Complete\ Mono.otf
    sudo mkfontscale
    sudo mkfontdir
    sudo fc-cache -fv
    rm -f fonts.dir fonts.scale
    print "Done."

    print "Trying to install zsh-plugin: autojump."
    sudo apt install -y autojump
    print "Done."

    print "Trying to install zsh-plugin: autosuggestions."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print "Done."

    print "Trying to install zsh-plugin: syntax-highlighting."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    print "Done."

    print "Trying to install fuzzy finder."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    print "Done."

    print "Trying to install fd."
    wget -c https://github.com/sharkdp/fd/releases/download/v7.3.0/fd_7.3.0_amd64.deb
    sudo dpkg -i fd_7.3.0_amd64.deb
    rm fd_7.3.0_amd64.deb
    print "Done."
}

setupZsh()
{
    print "Have you ever installed zsh in your computer? (y/n)"
    read ans
    if [ "$ans" == "n" ]; then
        print "Trying to install zsh."
        sudo apt install -y zsh
        print "Done."

        print "Trying to switch the shell to zsh."
        chsh -s /bin/zsh
        print "Don't forget to logout to enable zsh."
    fi

    print "Have you ever installed oh-my-zsh in your computer? (y/n)"
    read ans
    if [ "$ans" == "n" ]; then
        print "Trying to install oh-my-zsh."
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
        print "Done."
    fi

    doBackup "$HOME/.zshrc"
    cp "$appName"/zshrc "$HOME"/.zshrc

    installZshPlugins

    print "Thanks for installing my zsh!"
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

    print "Thanks for installing my tmux!"
}

############################ MAIN()
print "Welcome to $appName!"

if [ -z "$HOME" ]; then
    print "HOME environmental variable is required."
    exit 1
fi

if [ ! -e "./$appName" ]; then
    print "Trying to install git."
    sudo apt install -y git
    print "Done."

    cloneRepo
fi

print "Do you want to use my zsh? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    print "Zsh installation will begin......"
    setupZsh
fi

print "Do you want to use my tmux? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    print "Tmux installation will begin......"
    setupTmux
fi

print "Do you want to use my vim? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    print "Vim installation will begin......"
    setupNeovim
fi

print "Do you want to use my gitconfig? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    cp "$appName"/gitconfig ~/.gitconfig
fi

print "Do you want to use my flake8 configuration? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    cp "$appName"/flake8 ~/.config/flake8
fi

print "Do you want to use my vscodevim configuration? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    cp "$appName"/vscode.vimrc ~/vscode.vimrc
fi

# rm -rf "$appName"
rm install.sh

print "Thanks for installing $appName, enjoy it!"
