# $hgid:

# Just the cwd in the prompt
export PS1="[\w]$ "

# Use vi/vim
export EDITOR=vi

# Sane colors and not retarded x-mas tree syndrome
export LS_COLORS="no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=31:"

# Aliases
alias ls='ls -F --color'
alias l='ls'
alias la='ls -a'
alias lc='ls -lh'
alias lac='ls -Falh'

alias vim='vim -p'
alias vi=vim