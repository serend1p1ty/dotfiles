#!/bin/sh

set -e

for opt in "$@"; do
    case $opt in
        --vim)
            install_vim=1
            ;;
        --zsh)
            install_zsh=1
            ;;
        --zsh-offline)
            arch=$(uname -sm)
            install_zsh=2
            ;;
        --zsh-download=*)
            arch="${opt#*=}"
            install_zsh=3
            ;;
        --tmux)
            install_tmux=1
            ;;
        --gitconfig)
            install_gitconfig=1
            ;;
        *)
            # unknown option
            ;;
    esac
done

command_exists () {
    command -v "$1" >/dev/null 2>&1 || { echo ">>> $1 is not installed" >&2; exit 1; }
}

command_exists git
command_exists wget

this_file_dir=$(cd "$(dirname "$0")";pwd)
root=$this_file_dir/..
cd $root

if [ $install_vim -eq 1 ]; then
    command_exists vim
    git clone --depth=1 https://github.com/serend1p1ty/vim.git ~/.vim_runtime
    sh ~/.vim_runtime/install.sh
fi

if [ $install_zsh -ne 0 ]; then
    command_exists zsh
    if [ $install_zsh -eq 1 ]; then
        # online installation
        # oh-my-zsh
        wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

        # useful zsh plugins
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

        # fuzzy-finder, you want it!
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install

        # copy configuration file
        cp zshrc ~/.zshrc
    else
        version=0.33.0
        case "$arch" in
            Darwin\ arm64)   exec_file=fzf-$version-darwin_arm64.zip       ;;
            Darwin\ x86_64)  exec_file=fzf-$version-darwin_amd64.zip       ;;
            Linux\ armv5*)   exec_file=fzf-$version-linux_armv5.tar.gz     ;;
            Linux\ armv6*)   exec_file=fzf-$version-linux_armv6.tar.gz     ;;
            Linux\ armv7*)   exec_file=fzf-$version-linux_armv7.tar.gz     ;;
            Linux\ armv8*)   exec_file=fzf-$version-linux_arm64.tar.gz     ;;
            Linux\ aarch64*) exec_file=fzf-$version-linux_arm64.tar.gz     ;;
            Linux\ *64)      exec_file=fzf-$version-linux_amd64.tar.gz     ;;
            FreeBSD\ *64)    exec_file=fzf-$version-freebsd_amd64.tar.gz   ;;
            OpenBSD\ *64)    exec_file=fzf-$version-openbsd_amd64.tar.gz   ;;
            CYGWIN*\ *64)    exec_file=fzf-$version-windows_amd64.zip      ;;
            MINGW*\ *64)     exec_file=fzf-$version-windows_amd64.zip      ;;
            MSYS*\ *64)      exec_file=fzf-$version-windows_amd64.zip      ;;
            Windows*\ *64)   exec_file=fzf-$version-windows_amd64.zip      ;;
            *)               echo "unsupported architecture $arch"; exit 1 ;;
        esac

        if [ $install_zsh -eq 2 ]; then
            # offline installation
            cp -r third_party/oh-my-zsh ~/.oh-my-zsh
            cp -r third_party/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
            cp -r third_party/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/

            cp -r third_party/fzf ~/.fzf
            $exec_file_path=third_party/fzf/$exec_file
            if [ ! -f $exec_file_path ]; then
                echo ">>> $exec_file_path not found! Run './install.sh --zsh-download=your_arch' to download it."
            fi
            tar xvzf third_party/fzf/$exec_file -C ~/.fzf/bin/
            ~/.fzf/install

            # copy configuration file
            cp zshrc ~/.zshrc
        else
            echo ">>> Downloading third_party source code"
            git submodule update --init --recursive
            echo ">>> Downloading fzf binary to third_party/fzf/$exec_file"
            wget -O third_party/fzf/$exec_file https://github.com/junegunn/fzf/releases/download/$version/$exec_file
        fi
    fi
fi

if [ $install_tmux -eq 1 ]; then
    command_exists tmux
    cp tmux.conf ~/.tmux.conf
fi

if [ $install_gitconfig -eq 1 ]; then
    cp gitconfig ~/.gitconfig
fi

echo ">>> Installed the configuration successfully, enjoy it!"
