# $dotid$

if ($uname == win32) then
	bindkey -b N-up history-search-backward
	bindkey -b N-down history-search-forward
	bindkey -b N-right forward-char
	bindkey -b N-left backward-char
	bindkey -b N-del delete-char
	bindkey -b N-ins overwrite-mode
	bindkey -b N-1 which-command
	bindkey -b N-2 expand-history
	bindkey -b N-3 complete-word-raw
	bindkey -b N-home beginning-of-line
	bindkey -b N-end end-of-line

	bindkey -b M-x e_copy_to_clipboard
	bindkey -b M-y e_paste_from_clipboard
else
	# F1
	bindkey ^[[M run-help
	bindkey OP run-help
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
endif

# Insert
bindkey ^[[L yank
bindkey ^[[2 yank
