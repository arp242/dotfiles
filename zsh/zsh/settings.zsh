# http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

# Disable ^S/^Q - I never use that and I can actually use those keys now
stty -ixon
setopt noflowcontrol

setopt nomatch               # Show error if globbing fails
setopt notify                # Report status of bg jobs immediately
setopt nohup                 # Don't kill background jobs when exiting
setopt noclobber             # Don't clobber existing files with >
setopt nobeep                # Don't beep
setopt nobgnice              # Don't frob with nicelevels
setopt noautoremoveslash     # Too magic for my liking
setopt interactivecomments   # Allow comments in interactive shells
#setopt extendedglob          # More globbing characters

### Directory
setopt cdablevars            # Allow "go/desk" instead "~go/desk"
setopt autopushd             # Automatically keep a history
setopt pushdminus            # -0 counts from top, +0 from bottom
setopt pushdsilent           # Don't show stack after using pushd
setopt pushdignoredups       # Don't store duplicate entries

# I go here a lot; "cd ~tw/project"
tw=/home/martin/work/src/github.com/teamwork
go=/home/martin/go/src/arp242.net
code=/data/code

### History
setopt hist_ignore_dups      # Ignore duplicate in history.
setopt appendhistory         # Append to history, rather than overwriting
setopt incappendhistory      # Append immediately rather than only at exit
#setopt sharehistory          # Also read back new commands when writing history
setopt extendedhistory       # Store some metadata as well
setopt histnostore           # Don't store history or fc commands
HISTFILE=~/.zsh/history      # Store history here
HISTSIZE=8000                # Max. entries to keep in memory
SAVEHIST=8000                # Max. entries to save to file

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
