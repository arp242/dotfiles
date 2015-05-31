" https://github.com/gioele/vim-autoswap


augroup AutoSwap
    autocmd!
    autocmd SwapExists * call HandleSwapfile(expand('<afile>:p'))
augroup end


fun! HandleSwapfile(filename)
	let l:session = FindSession(a:filename)

	" Found a live session with this file
	if l:session != ''
		echomsg 'Switching to existing session `' . l:session . "'"
		call DelayedMsg('Switching to existing session `' . l:session . "'")
		call FocusSession(l:session)
		let v:swapchoice = 'q'
	" Otherwise, if swapfile is older than file itself, just get rid of it
	elseif getftime(v:swapname) < getftime(a:filename)
		echomsg 'File is newer than swap file; removing it'
		call DelayedMsg('File is newer than swap file; removing it')
		call delete(v:swapname)
		let v:swapchoice = 'e'
	" TODO: diff for changes?
	" Otherwise, open file read-only
	else
		echomsg 'Swapfile detected, opening read-only'
		call DelayedMsg('Swapfile detected, opening read-only')
		let v:swapchoice = 'o' " TODO: Why not recover?
	endif
endfun

" Print a message after the autocommand completes
" (so you can see it, but don't have to hit <ENTER> to continue)...
function! DelayedMsg (msg)
	" A sneaky way of injecting a message when swapping into the new buffer...
	augroup AutoSwap_Msg
		autocmd!
		" Print the message on finally entering the buffer...
		autocmd BufWinEnter * echohl WarningMsg
		exec 'autocmd BufWinEnter * echon "\r' . printf("%-60s", a:msg) . '"'
		autocmd BufWinEnter * echohl NONE

		" And then remove these autocmds, so it's a "one-shot" deal...
		autocmd BufWinEnter * augroup AutoSwap_Msg
		autocmd BufWinEnter * autocmd!
		autocmd BufWinEnter * augroup END
	augroup end
endfunction


fun! FindSession(filename)
	for server in split(serverlist(), '\n')
		if l:server == v:servername
			continue
		endif

		if remote_expr(l:server, 'bufexists("' . a:filename . '")')
			return l:server
		end
	endfor

	return ''
endfun


fun! FocusSession(session)
	" This will only work in the Win32, Athena, Motif and GTK GUI versions and
	" the Win32 console version (notably, not Vim inside a Terminal emulator).
	if remote_expr(a:session, 'has("gui_running") || has("win32")')
		call remote_foreground(a:session)
	" Try to use xdotool for Vim inside a terminal emulator
	elseif system('which xdotool > /dev/null && echo -n 0 || echo -n 1') == '0'
		let l:id = system('xdotool search --name ' . a:session)[:-2]

		" Move to desktop the window is on
		"call system('xdotool windowactivate ' . l:id)

		" Move the window to the current desktop
		let l:desktop = system('xdotool get_desktop')[:-2]
		call system(printf('xdotool set_desktop_for_window %s %s; xdotool windowfocus %s windowraise %s', l:id, l:desktop, l:id, l:id))
	" TODO: we can also use wmctrl
	" :-( Give up
	else
		echomsg "Can't find a way to focus `" . a:session . "'"
	endif

	" This is from AutoSwap_Mac, I don't have an OSX machine so I can't test it
	"call system('osascript -e ''tell application "Terminal" to set frontmost of ' . a:active_window . ' to true''')
endfun
