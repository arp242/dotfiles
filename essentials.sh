#!/bin/sh
#
# Quickly install essentials (tcsh, tmux, vim)
# curl -s http://code.arp242.net/config/raw/tip/essentials.sh | sh

cd ~
wget http://code.arp242.net/config/get/tip.tar.gz
tar xf tip.tar.gz
rm tip.tar.gz

cd Carpetsmoker-config-*

cp ./home/dot.tcshrc ~/.tcshrc
cp -r ./home/dot.tcsh ~/.tcsh

cp -r ./home/dot.tmux.conf ~/.tmux.conf

cp ./home/dot.vimrc ~/.vimrc
cp -r ./home/dot.vim ~/.vim
