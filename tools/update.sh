path=$(cd "$(dirname "$0")";pwd)

if [ $1 == "up" ]; then
    echo "Upload vim configuration."
    cp ~/.config/nvim/* $path/../vim -rf
    rm $path/../vim/plugged -rf
fi

if [ $1 == "down" ]; then
    echo "Download vim configuration."
    cp $path/../vim/* ~/.config/nvim -rf
fi
