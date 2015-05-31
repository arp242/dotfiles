" $dotid$

" Show a fortune on startup
augroup fortune
	autocmd!
	autocmd VimEnter * call Start()
augroup end


" Set a fancy start screen
fun! Start()
	" Don't run if: we have commandline arguments, we don't have an empty
	" buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
	if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
		return
	endif

	" Start a new buffer ...
	enew

	" ... and set some options for it
	setlocal
		\ bufhidden=wipe
		\ buftype=nofile
		\ nobuflisted
		\ nocursorcolumn
		\ nocursorline
		\ nolist
		\ nonumber
		\ noswapfile
		\ norelativenumber

	" Now we can just write to the buffer whatever you want.
	call append('$', "")
	for line in split(system('fortune -a'), '\n')
		call append('$', '        ' . l:line)
	endfor

	" No modifications to this buffer
	setlocal nomodifiable nomodified

	" Moar fortunes! :-)
	nnoremap <buffer> <Return> :enew<CR>:call Start()<CR>

	" When we go to insert mode start a new buffer, and start insert
	nnoremap <buffer><silent> e :enew<CR>
	nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
	nnoremap <buffer><silent> o :enew <bar> startinsert<CR><CR>
endfun
