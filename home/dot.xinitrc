#!/bin/sh
#

__run()
{
	local t=$(which $1)
	if [ $? -eq 0 ]; then
		$* &
	fi
}

cd ~

# X settings
if [ -f ~/.wallpaper.png ]; then
    __run qiv -y ~/.wallpaper.png
else
    xsetroot -solid "#3A6EA5"
fi

xset -b
xmodmap ~/.Xmodmap
setxkbmap -option compose:caps
xbacklight -set 30

# moused does this on FreeBSD much better than X
if [ $(uname -s) = FreeBSD ]; then
	xset m 1/1 1
	mixer vol 75 pcm 75
else
	xset m 4/8 1
fi

__run xbindkeys
__run parcellite
__run pidgin
__run mailtray
__run battray
__run docker -vertical

t=$(which pekwm)
if [ $? -eq 0 ]; then
	exec ssh-agent pekwm
	#exec hest
else
	exec ssh-agent twm
fi
