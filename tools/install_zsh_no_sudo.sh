#!/bin/sh

set -e

mkdir ~/tmp && cd ~/tmp
wget https://sourceforge.net/projects/zsh/files/zsh/5.8/zsh-5.8.tar.xz
tar xvf zsh-5.8.tar.xz && cd zsh-5.8
./configure --prefix=$HOME
make && make install

rm ~/tmp -rf

echo "exec ~/bin/zsh -l" >> ~/.bashrc
