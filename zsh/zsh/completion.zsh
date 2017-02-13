# Completion

setopt completeinword        # Allow completion from within a word/phrase
setopt alwaystoend           # Move cursor to end of word when when completing from middle
setopt nolistambiguous       # Show options on single tab press

# Load and init
autoload -Uz compinit && compinit
zstyle ':completion:*' completer _expand _complete _ignored

# Make completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Always ignore these files
zstyle ':completion:*' ignored-patterns '*?.pyc' '*?.o'

# Use menu
zstyle ':completion:*' menu select

# Show warning when there are no completions
zstyle ':completion:*:warnings' format 'No completions'

# TODO:
# Shift+tab
# show help text in different colour or something
#


# -----

# Show colours
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#http://zsh.sourceforge.net/FAQ/zshfaq04.html#l46

# Use menu

#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*' menu select=2
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
#zstyle ':completion::complete:*' use-cache 1

#zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
