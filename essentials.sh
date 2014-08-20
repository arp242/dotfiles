#!/bin/sh
#
# Quickly install essentials
# curl -s http://code.arp242.net/config/src/tip/essentials.sh | sh

cd ~
wget http://code.arp242.net/config/get/tip.tar.gz
tar xf tip.tar.gz
rm tip.tar.gz

cd Carpetsmoker-config-*

cp ./home/dot.tcshrc ~/.tcshrc
cp -r ./home/dot.tcsh ~/.tcsh
cp ./home/dot.tcshrc ~/.vimrc
cp -r ./home/dot.tcsh ~/.vim
cp -r ./home/dot.tmux.conf ~/.tmux.conf
