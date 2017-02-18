# Called when dir changes
chpwd() {
	print -Pn "\e]2;zsh: %~\a"
}

# Rename files with globbing, like DOS: "mv *.txt *.md"
autoload -U zmv

if [[ $uname = Linux ]]; then
	alias ls='ls -FN --color'

	alias lc='ls -lh'
	alias la='ls -A'
	alias lac='ls -lhA'
	alias lsd='ls -ld *(-/DN)'
	alias lh='ls -d .*'
	alias grep="grep --color"

	alias sockstat="netstat -lnptu --protocol=inet,unix"
	if _exists systemctl; then
		alias zzz='systemctl suspend'
	elif _exists pm-suspend; then
		alias zzz=sudo pm-suspend
	fi

	_exists bsdtar && alias tar=bsdtar
	_exists htop && alias top=htop
else
	alias la="ls -a"
	alias lc="ls -l"
	alias lac="ls -la"
fi

# A few more aliases...
alias cp="cp -i"
alias mv="mv -i"
alias make="nice -n 20 make"
alias j="jobs -l"
alias lman="groff -man -Tascii" # `local man' <file>.1
alias rdiff="diff -urN -x CVS -x .svn -x .git -x .hg "
alias decolor="sed 's|\x1b\[[;0-9]*m||g'"
alias trcolor="sed -e 's|\x1b\[36m|\x1b\[31m|g'; 's|\x1b\[33m|\x1b\[31m|g'"

alias ag='ag -S --color-match 31 --color-line-number 35 --color-path 1\;4'
alias youtube-dl='youtube-dl --no-part --title'
alias mplayer=mpv

if _exists drill; then
	alias dig=drill
elif _exists dig; then
	alias drill=dig
fi

# CSH habit...
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }

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
alias les=less
alias Less=less

# Global aliases
alias -g /t='| tail'
alias -g /v='| vim -'
alias -g /l='| less'
