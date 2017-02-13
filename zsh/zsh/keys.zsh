# "Emacs" bindings
bindkey -e

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line
zle -N down-line-or-beginning-search
zle -N edit-command-line
zle -N up-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[[H'  beginning-of-line              # Home
bindkey '^[[F'  end-of-line                    # End
bindkey '^[[3~' delete-char                    # Delete
bindkey '^[[5~' up-line-or-history             # Page up
bindkey '^[[6~' down-line-or-history           # Page down
bindkey '^Xe'   edit-command-line              # ^Xe
bindkey '^[OP'  run-help                       # F1
