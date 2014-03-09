#!/bin/sh

_run()
{
	local t=$(which $1 > /dev/null 2>&1)
	if [ $? -eq 0 ]; then
		$* &
	fi
}

cd ~

# X settings
_run xset -b
_run xmodmap ~/.Xmodmap
_run xbacklight -set 0
_run xsetroot -solid "#3a6ea5"
_run xrdb ~/.Xdefaults
[ -f ~/.wallpaper.png ] _run qiv -y ~/.wallpaper.png

# moused does this on FreeBSD much better than X
if [ $(uname -s) = FreeBSD ]; then
	_run xset m 1/1 1
else
	_run xset m 4/8 1
fi

_run parcellite
_run trayer --edge bottom --align right --widthtype request --expand true

if [ -f ~/.xsession_local ]; then
	. ~/.xsession_local
fi


