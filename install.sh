#!/bin/sh
#
# Intended for easy (remote) install:
#
# curl http://code.arp242.net/config/raw/tip/install.sh | sh -s
# curl http://code.arp242.net/config/raw/tip/install.sh | sh -s @group_name module_name
#

set -euC

groups=""

echo $@

#tmp=$(mktemp -d)
#curl -s http://code.arp242.net/config/get/tip.tar.gz | tar xf - -C "$tmp"
#repo=/tmp/tmp.nCgHfpUTNW/*

#rm -r "$tmp"
