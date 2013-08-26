#!/bin/sh
# $hgid:

_run()
{
	local t=$(which $1 > /dev/null)
	if [ $? -eq 0 ]; then
		$* &
	fi
}

cd ~

# X settings
xset -b
xmodmap ~/.Xmodmap
setxkbmap -option compose:caps
xbacklight -set 30
xsetroot -solid "#3a6ea5"

if [ -f ~/.wallpaper.png ]; then
    _run qiv -y ~/.wallpaper.png
fi

# moused does this on FreeBSD much better than X
if [ $(uname -s) = FreeBSD ]; then
	xset m 1/1 1
else
	xset m 4/8 1
fi

_run parcellite
_run pidgin
_run mailtray
_run redshift
_run trayer --edge bottom --align right --widthtype request --expand true

if [ -f ~/.xinitrc_local ]; then
	. ~/.xinitrc_local
fi

t=$(which pekwm > /dev/null)
if [ $? -eq 0 ]; then
	exec ssh-agent pekwm
else
	exec ssh-agent twm
fi
