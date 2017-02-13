# Called when dir changes
chpwd() {
	print -Pn "\e]2;zsh: %~\a"
}

# precmd()
# preexec()

# zmv -  a command for renaming files by means of shell patterns.
autoload -U zmv

# zargs, as an alternative to find -exec and xargs.
autoload -U zargs

if [[ $uname = FreeBSD ]]; then
	alias ls="ls-F -I"
	alias la="ls-F -A"
	alias lc="ls-F -lThoI"
	alias lac="ls-F -lThoA"

	# bsdgrep is FreeBSD >=9
	# bsdgrep doesn't seem stable/reliable (yet)
	#if exists bsdgrep; then
	#	alias grep="bsdgrep --color"
	#else
		alias grep="grep --color"
	#fi
elif [[ $uname = OpenBSD ]]; then
	if _exists colorls; then
		alias ls="colorls -FG"
		alias la="colorls -FGA"
		alias lc="colorls -FGlTho"
		alias lac="colorls -FGlThoA"
	else
		alias ls="ls -F"
		alias la="ls -FA"
		alias lc="ls -FlTho"
		alias lac="ls -FAlTho"
	fi
elif [[ $uname = Linux ]]; then
	#unalias ls

	# -N disabled retarded GNU shit of quoting the filenames (which is suddenly
	# the default?!)
	# No idea how compatible it is...
	alias ls='ls -FN --color'
	alias l=ls

	alias lc='ls -lh'
	alias la='ls -A'
	alias lac='ls -lhA'
	alias grep="grep --color"

	alias sockstat="netstat -lnptu --protocol=inet,unix"
	if _exists systemctl; then
		alias zzz='systemctl suspend'
	elif _exists pm-suspend; then
		alias zzz=sudo pm-suspend
	fi

	# bsdtar/libarchive works with many file formats, not just tar
	_exists bsdtar && alias tar=bsdtar

	# Linux top is an unusable piece of shit after recent changes
	_exists htop && alias top=htop
else
	# These should work on almost any platform ...
	alias la="ls -a"
	alias lc="ls -l"
	alias lac="ls -la"
fi

# Override the tcsh builtins
#if (-x /usr/bin/nice) then
#	alias nice="/usr/bin/nice"
#elif (-x /bin/nice) then
#	alias nice="/bin/nice"
#endif
#if (-x /usr/bin/time) alias time="/usr/bin/time -h"

# A few more aliases...
alias cp="cp -i"
alias mv="mv -i"
alias make="nice -n 20 make"
alias j="jobs -l"
alias lman="groff -man -Tascii" # `local man' <file>.1

# Third-party stuff
_exists mpv && alias music="mpv $* *.{mp3,flac}"

if _exists drill; then
	alias dig=drill
elif _exists dig; then
	alias drill=dig
fi

alias ag='ag -S --color-match 31 --color-line-number 35 --color-path 1\;4'

# Use title in filename
alias youtube-dl='youtube-dl --no-part -t'

# Typos
alias sl="ls"
alias l="ls"
alias c="cd"
alias vo="vi"
alias ci="vi" # ci already exists, but few people use it and it mangles files!
alias iv="vi" # Some image viewer I never use, annoying
alias grpe="grep"
alias Grep="grep"
alias les=less

# Visual separator
alias sep="echo '\033[1;34m=========================================\033[0m'"

# http://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream#380778
# man Term::ANSIColor 
# http://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# http://www.andrewnoske.com/wiki/Unix_-_ANSI_colors
alias decolor="sed 's|\x1b\[[;0-9]*m||g'"
alias trcolor="sed -e 's|\x1b\[36m|\x1b\[31m|g'; 's|\x1b\[33m|\x1b\[31m|g'"

# Until I can find/make a colour scheme that works
alias ipython='ipython --colors=NoColor --no-confirm-exit'

alias xvi=xvim
alias write="mlterm -e vim -c :WriteMode\ '&'"
alias vh='vim -c ':help $1' -c :only'         
alias vims='vim -c ScratchBuffer'
alias vim-basic='vim -u ~/.vim/basic'
alias tclsh='rlwrap tclsh'

alias mplayer=mpv

alias rdiff="diff -urN -x CVS -x .svn -x .git -x .hg "

# Prettify JSON from clipboard
alias jsonpp='xclip -o | python -mjson.tool | xclip -i'
