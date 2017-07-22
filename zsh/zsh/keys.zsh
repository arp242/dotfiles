# "Vi" bindings
bindkey -v

# The time the shell waits, in hundredths of seconds, for  another
# key to be pressed when reading bound multi-character sequences.
# export KEYTIMEOUT=40
export KEYTIMEOUT=10

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line
zle -N insert-sudo insert_sudo

bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search
bindkey '^[[H'  beginning-of-line              # Home
bindkey '^[[1~' beginning-of-line
bindkey '^[[7~' beginning-of-line
bindkey '^[[F'  end-of-line                    # End
bindkey '^[[4~' end-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[3~' delete-char                    # Delete
bindkey '^[[5~' up-line-or-history             # Page up
bindkey '^[[6~' down-line-or-history           # Page down
bindkey '^[OP'  run-help                       # F1
bindkey '^h'    backward-delete-char           # Backspace
bindkey '^?'    backward-delete-char

bindkey '^a'    beginning-of-line
bindkey '^k'    kill-line
bindkey '^p'    up-line-or-beginning-search
bindkey '^n'    down-line-or-beginning-search
bindkey '^e'    edit-command-line
bindkey '^s'    insert-sudo
bindkey '^I'    complete-word                  # complete on tab, leave expansion to _expand
                                               # Useful for going back in menu completion
bindkey '^[[Z'  up-history                     # Shift+Tab

# Use this completion and start completion for new dir
bindkey -M menuselect '^o' accept-and-infer-next-history

#bindkey ' ' magic-space    # also do history expansion on space
