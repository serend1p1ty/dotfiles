cur_file_path=$(cd "$(dirname "$0")";pwd)
root=$cur_file_path/..

if [ $1 == "up" ]; then
    echo "Upload configuration."
    cp ~/.tmux.conf $root/tmux.conf
    cp ~/.zshrc $root/zshrc
    cp ~/.gitconfig $root/gitconfig
fi

if [ $1 == "down" ]; then
    echo "Download configuration."
    cp $root/tmux.conf ~/.tmux.conf
    cp $root/zshrc ~/.zshrc
    cp $root/gitconfig ~/.gitconfig
fi
