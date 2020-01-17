path=$(cd "$(dirname "$0")";pwd)

if [ $1 == "up" ]; then
    echo "Upload configuration."

    cp ~/.config/nvim/* $path/../vim -rf
    rm $path/../vim/plugged -rf

    cp ~/.tmux.conf $path/../tmux.conf
    cp ~/.zshrc $path/../zshrc
    cp ~/.gitconfig $path/../gitconfig
    cp ~/vscode.vimrc $path/../vscode.vimrc
fi

if [ $1 == "down" ]; then
    echo "Download configuration."
    cp $path/../vim/* ~/.config/nvim -rf
    cp $path/../tmux.conf ~/.tmux.conf
    cp $path/../zshrc ~/.zshrc
    cp $path/../gitconfig ~/.gitconfig
    cp $path/../vscode.vimrc ~/vscode.vimrc
fi
