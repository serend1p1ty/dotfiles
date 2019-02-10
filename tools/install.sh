#!/bin/sh

set -e

cur_file_path=$(cd "$(dirname "$0")";pwd)
root=$cur_file_path/..

echo ">>> Use vim? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    git clone --depth=1 https://github.com/serend1p1ty/vim.git ~/.vim_runtime
    sh ~/.vim_runtime/install.sh
fi

echo ">>> Use zsh? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    # oh-my-zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

    # theme
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k --depth=1

    # useful plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # fuzzy-finder, you want it!
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    # copy configuration file
    cp $root/zshrc ~/.zshrc
fi

echo ">>> Use tmux? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    cp $root/tmux.conf ~/.tmux.conf
fi

echo ">>> Use gitconfig? (y/n)"
read ans
if [ "$ans" == "y" ]; then
    cp $root/gitconfig ~/.gitconfig
fi

echo ">>> Installed the configuration successfully, enjoy it!"