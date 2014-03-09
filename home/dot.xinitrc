#!/bin/sh
# $hgid:

[ -f ~/.xsession ] && . ~/.xsession

t=$(which pekwm > /dev/null)
if [ $? -eq 0 ]; then
	exec ssh-agent pekwm
else
	exec ssh-agent twm
fi
