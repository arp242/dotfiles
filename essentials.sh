#!/bin/sh
#
# Quickly install essentials (tcsh, tmux, vim)
# curl -s http://code.arp242.net/config/raw/tip/essentials.sh | sh

cd ~

curl -s fetch http://code.arp242.net/config/get/tip.tar.gz > tip.tar.gz

tar xf tip.tar.gz
rm tip.tar.gz

cd Carpetsmoker-config-*

# tcsh
cp ./home/dot.tcshrc ~/.tcshrc
cp -r ./home/dot.tcsh ~/.tcsh

# tmux
cp ./home/dot.tmux.conf ~/.tmux.conf

# Vim
cp -r ./home/dot.vim ~/.vim
