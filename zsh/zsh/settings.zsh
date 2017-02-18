# http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

### Various
setopt nomatch               # Show error if globbing fails
setopt notify                # Report status of bg jobs immediately
setopt nohup                 # Don't kill background jobs when exiting
setopt noclobber             # Don't clobber existing files with >
# TODO: too noise; would prefer it to just print "Exit n"
#setopt printexitvalue        # Show exit code if non-zero
unsetopt beep                # Don't beep
unsetopt bgnice              # Don't frob with nicelevels
unsetopt autoremoveslash     # Too magic for my liking

#setopt extendedglob

# https://wiki.archlinux.org/index.php/Zsh#Dirstack
#setopt autopushd
#setopt pushdminus
#setopt pushdignoredups

# Disable ^S/^Q - I never use them and I can use those keys in Vim now
stty -ixon
setopt noflowcontrol

### History
setopt hist_ignore_dups      # Ignore duplicate in history.
setopt interactivecomments   # Allow comments in interactive shells
setopt appendhistory         # Append to history, rather than overwriting
HISTFILE=~/.zsh/history
HISTSIZE=8000
SAVEHIST=4000

### Prompt
setopt promptsubst           # Expand parameters commands, and arithmetic in PROMPT

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(%b)'
#zstyle ':vcs_info:*' check-for-changes true

set_prompt() {
	vcs_info
	# TODO: Ignore 130 (^C)
	echo "%(?..%S %? %s)[%~]${vcs_info_msg_0_}%# "
}

set_rprompt() {
	local host='%U%B%m%b%u'
	if [[ -n "${SSH_CLIENT}${SSH2_CLIENT}${SSH_CONNECTION}" ]]; then 
		host="%F{red}${host}%f"
	fi
	#echo "%(?..%S%?%s )${host}:%T"
	echo "${host}:%T"
}

PROMPT=$'$(set_prompt)'
RPROMPT=$'$(set_rprompt)'
