#!/bin/sh
#
# Quickly install essentials (tcsh, tmux, vim)
# curl -s http://code.arp242.net/config/raw/tip/essentials.sh | sh

cd ~

curl -s fetch http://code.arp242.net/config/get/tip.tar.gz > tip.tar.gz

tar xf tip.tar.gz
rm tip.tar.gz

cd Carpetsmoker-config-*

cp ./home/dot.tcshrc ~/.tcshrc
cp -r ./home/dot.tcsh ~/.tcsh

cp ./home/dot.tmux.conf ~/.tmux.conf

cp -r ./home/dot.vim ~/.vim
