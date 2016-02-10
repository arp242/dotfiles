#!/bin/sh
#
# Intended for easy (remote) install:
#   curl -s https://bitbucket.org/Carpetsmoker/config/raw/tip/install.sh | sh -s
# or:
#   curl -s http://arp242.net/install.sh | sh -s
#
# TODO: Allow more parameters, like:
#   curl -s http://code.arp242.net/config/raw/tip/install.sh | sh -s @group_name module_name
#

set -euC

echo "$@"

tmp=$(mktemp -d)
curl -s https://bitbucket.org/Carpetsmoker/config/get/tip.tar.gz | tar xzf - -C "$tmp"

echo $tmp
cd "$tmp"/*
cd "$tmp"/* && ./manage-dotfiles.py tcsh tmux vim bash CLOBBER_IT_ALL
rm -r "$tmp"
