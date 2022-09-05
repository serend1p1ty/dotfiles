this_file_dir=$(cd "$(dirname "$0")";pwd)
root=$this_file_dir/..
cd $root

if [ $1 == "up" ]; then
    echo "Upload configuration."
    cp ~/.tmux.conf tmux.conf
    cp ~/.zshrc zshrc
    cp ~/.gitconfig gitconfig
fi

if [ $1 == "down" ]; then
    echo "Download configuration."
    cp tmux.conf ~/.tmux.conf
    cp zshrc ~/.zshrc
    cp gitconfig ~/.gitconfig
fi
