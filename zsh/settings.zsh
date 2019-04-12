# http://zanshin.net/2013/02/02/zsh-configuration-from-the-ground-up/

stty -ixon quit undef        # Disable ^S, ^Q, ^\

setopt noflowcontrol         # Disable useless ^S and ^Q
setopt notify                # Report status of bg jobs immediately
setopt nohup                 # Don't kill background jobs when exiting
setopt noclobber             # Don't clobber existing files with >
setopt nobeep                # Don't beep
setopt nobgnice              # Don't frob with nicelevels
setopt interactivecomments   # Allow comments in interactive shells
setopt noautoremoveslash     # Don't guess when slashes should be removed (too magic)
setopt nomatch               # Show error if globbing fails
setopt extendedglob          # More globbing characters
LISTMAX=999999               # Disable 'do you wish to see all %d possibilities'

### Directory
setopt autopushd             # Automatically keep a history
setopt pushdminus            # -0 counts from top, +0 from bottom
setopt pushdsilent           # Don't show stack after using pushd
setopt pushdignoredups       # Don't store duplicate entries

### History
setopt hist_ignore_dups      # Ignore duplicate in history.
setopt appendhistory         # Append to history, rather than overwriting
setopt incappendhistory      # Append immediately rather than only at exit
#setopt sharehistory          # Also read back new commands when writing history
setopt extendedhistory       # Store some metadata as well
setopt histnostore           # Don't store history or fc commands
setopt histignorespace       # Don't add commands starting with space to history.
HISTFILE=~/.zsh/history      # Store history here
HISTSIZE=40000               # Max. entries to keep in memory
SAVEHIST=40000               # Max. entries to save to file
HISTORY_IGNORE='([bf]g *|disown|cd ..|cd -)' # Don't add these to the history file.

### Prompt
setopt promptsubst           # Expand parameters commands, and arithmetic in PROMPT

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(%b)'
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git:*:martin' formats "\u200b"

# Set mode variable for prompt
function zle-line-init zle-keymap-select {
	mode="${${KEYMAP/vicmd/n}/(main|viins)/i}"
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

set_prompt() {
	vcs_info

	print -n "%(?..%S %? %s)"           # Exit code in "standout" if non-0.
	[[ $mode = n ]] && print -n "%S"    # Directory as "standout" in normal mode.
	print -n "[%~]${vcs_info_msg_0_}%#" # Directory and VCS info (if any).
	[[ $mode = n ]] && print -n "%s"    # End standout.
	print -n ' '
}

set_rprompt() {
	local host='%U%B%m%b%u'
	if [[ -n "${SSH_CLIENT}${SSH2_CLIENT}${SSH_CONNECTION}" ]]; then
		host="%F{red}${host}%f"
	fi
	print "${mode}:${host}:%T"
}

PROMPT=$'$(set_prompt)'
RPROMPT=$'$(set_rprompt)'
