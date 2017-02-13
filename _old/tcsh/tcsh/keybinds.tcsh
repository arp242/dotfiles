# $dotid$

# F1
bindkey ^[[M run-help
bindkey ^[OP run-help
bindkey ^[[11~ run-help # Putty

# Delete
bindkey ^[[3~ delete-char

# Home
bindkey ^[[H beginning-of-line
bindkey ^[[1~ beginning-of-line

# End
bindkey ^[[F end-of-line
bindkey ^[[4~ end-of-line

# Arrow keys
bindkey -k up history-search-backward
bindkey -k down history-search-forward

# Page Up, Page Down
bindkey "^[[5~" undefined-key
bindkey "^[[6~" undefined-key

# Insert
bindkey ^[[L yank
bindkey ^[[2 yank
