# Called when dir changes
chpwd() {
	print -Pn "\e]2;zsh: %~\a"
}

# Rename files with globbing, like DOS: "mv *.txt *.md"
autoload -U zmv

if [[ $uname = Linux ]]; then
	alias ls='ls -FN --color=auto'

	alias lc='ls -lh'
	alias la='ls -A'
	alias lac='ls -lhA'
	alias lsd='ls -ld *(-/DN)'
	alias lh='ls -d .*'
	alias grep='grep --color'

	alias sockstat='netstat -lnptu --protocol=inet,unix'
	if _exists systemctl; then
		alias zzz='systemctl suspend'
	elif _exists pm-suspend; then
		alias zzz='sudo pm-suspend'
	fi

	_exists bsdtar && alias tar='bsdtar'
	_exists htop   && alias top='htop'
else
	alias la='ls -a'
	alias lc='ls -l'
	alias lac='ls -la'
fi

# A few more aliases.
alias cp='cp -i'
alias mv='mv -i'
alias make='nice -n 20 make'
alias j='jobs -l'
alias lman='groff -man -Tascii' # `local man' <file>.1
alias rdiff='diff -urN -x CVS -x .svn -x .git -x .hg '
alias decolor="sed 's|\x1b\[[;0-9]*m||g'"
alias trcolor="sed -e 's|\x1b\[36m|\x1b\[31m|g'; 's|\x1b\[33m|\x1b\[31m|g'"

_exists ag         && alias ag='ag -S --color-match 31 --color-line-number 35 --color-path 1\;4'
_exists youtube-dl && alias youtube-dl='youtube-dl --no-part -o "%(title)s-%(id)s.%(ext)s"'
_exists mpv        && alias mplayer='mpv'

if _exists git; then
	alias g='git'
	alias gst='git st'
	alias gst='git diff'
	alias gci='git commit'
	alias grebase='git rebase'
fi

if _exists drill; then
	alias dig='drill'
elif _exists dig; then
	alias drill='dig'
fi

# Typos
alias sl='ls'
alias l='ls'
alias c='cd'
alias vo='vi'
alias dirs='dirs -v'
alias d='dirs'
alias fd='pushd'
alias ci='vi' # ci already exists, but few people use it and it mangles files!
alias iv='vi' # Some image viewer I never use, annoying
alias grpe='grep'
alias Grep='grep'
alias les='less'
alias les='less'
alias Less='less'
alias cd.='cd .'
alias cd..='cd ..'

# Global aliases
alias -g /t='|& tail'
alias -g /v='|& vim -'
alias -g /l='|& less'

# "ag edit" and "grep edit".
age() {
	#vim +'normal! gg' +"/$1" +n -p $(ag $@ | cut -d: -f1 | sort -u | xargs)
	vim +"/$1" -p $(ag "$@" | cut -d: -f1 | sort -u)
}
grepe() {
	vim -p $(grep "$@" | cut -d: -f1 | sort -u)
}

# Rename all files in the current directory to lowercase
lwr() {
	for f in ./*; do
		nf="$(echo "${f}" | tr '[:upper:]' '[:lower:]')"
		mv -v "${f}" "${nf}"
	done
}

# "Short awk"
sawk() {
	awk "{print \$$1}"
}

# pushd function to emulate the old zsh behaviour.
# With this, pushd +/-n lifts the selected element
# to the top of the stack instead of cycling
# the stack.
#pushd() {
#	emulate -R zsh
#	setopt localoptions
#
#	if [[ ARGC -eq 1 && "$1" == [+-]<-> ]] then
#		setopt pushdignoredups
#		builtin pushd ~$1
#	else
#		builtin pushd "$@"
#	fi
#}
