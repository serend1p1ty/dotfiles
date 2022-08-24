#!/bin/sh

set -e

this_file_path=$(cd "$(dirname "$0")";pwd)
root=$this_file_path/..

command_exists () {
    command -v "$1" >/dev/null 2>&1 || { echo "$1 is not installed" >&2; exit 1; }
}

command_exists git
command_exists wget

echo ">>> Use vim? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    command_exists vim
    git clone --depth=1 https://github.com/serend1p1ty/vim.git ~/.vim_runtime
    sh ~/.vim_runtime/install.sh
fi

echo ">>> Use zsh? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    command_exists zsh
    echo ">>> Online installation? (y/n)"
    read ans
    if [ "$ans" == "y" ]; then
        # oh-my-zsh
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

        # useful plugins
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        # fuzzy-finder, you want it!
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    else
        cp -r $root/third_party/oh-my-zsh ~/.oh-my-zsh
        cp -r $root/third_party/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
        cp -r $root/third_party/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
        echo ">>> Offline installation does not support fzf yet."
    fi

    # copy configuration file
    cp $root/zshrc ~/.zshrc
fi

echo ">>> Use tmux? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    command_exists tmux
    cp $root/tmux.conf ~/.tmux.conf
fi

echo ">>> Use gitconfig? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    cp $root/gitconfig ~/.gitconfig
fi

echo ">>> Installed the configuration successfully, enjoy it!"
