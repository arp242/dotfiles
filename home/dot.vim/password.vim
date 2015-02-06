" If there are less than 3 + (bytes / 100) newlines, we assume the password
" is incorrect, and we're displaying a bunch of gibberish. Quit, and try
" again
if getline(1) != '' && line("$") < 3 + (line2byte(line("$")) / 100)
	" User pressed ^C
	if strpart(getline("."), 0, 12) == "VimCrypt~02!"
		quit!
	else
		cquit!
	endif
endif
