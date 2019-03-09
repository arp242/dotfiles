# Completion

setopt completeinword        # Allow completion from within a word/phrase
setopt alwaystoend           # Move cursor to end of word when when completing from middle
setopt nolistambiguous       # Show options on single tab press

# Load and init
autoload -Uz compinit && compinit && zmodload zsh/complist
zstyle ':completion:*' completer _expand _complete _ignored

# Make completion case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Always ignore these files/functions
zstyle ':completion:*:files' ignored-patterns '*?.pyc' '*?.o'
zstyle ':completion:*:functions' ignored-patterns '_*'

# Show more info in some completions
zstyle ':completion:*' verbose yes

# Show warning when there are no completions
zstyle ':completion:*:warnings' format 'No completions'

# Show ls-like colours in file completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Use menu
zstyle ':completion:*' menu select

# TODO:
# show help text in different colour or something
