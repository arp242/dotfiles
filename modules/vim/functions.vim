" $dotid$


" :retab changes *everything*, not just start of lines
fun! Retab(expandtab)
	let l:save_cursor = getpos(".")
	let l:spaces = repeat(' ', &tabstop)

	" Replace tabs with spaces
	if a:expandtab
		silent! execute '%substitute#^\%(' . l:spaces . '\)\+#\=repeat("\t", len(submatch(0)) / &tabstop)#e'
	" Replace spaces with tabs
	else
		silent! execute '%substitute#^\%(\t\)\+#\=repeat("' . l:spaces . '", len(submatch(0)))#e'
	endif
	call setpos('.', l:save_cursor)
endfun
command! -nargs=1 Retab call Retab(<args>)

" Write as root user; re-read file
fun! SuperWrite()
	silent write !sudo tee %
	edit!
endfun
command! SuperWrite call SuperWrite()


" 'Write mode' removes most UI chrome, and sets a margin on the left side. I
" like it for writing emails and such.
fun! WriteMode()
	" Disable a lot of stuff
	setlocal nocursorline nocursorcolumn statusline= showtabline=0 laststatus=0 noruler

	" Hack a right margin with number
	setlocal number
	setlocal numberwidth=3

	" Works better for me than my default of 80
	if &filetype != 'mail'
		setlocal textwidth=100
	endif

	" White text, so it's 'invisible'
	highlight LineNr ctermfg=15
	" If you're using a black background:
	" highlight LineNr ctermfg=1
endfun
command! WriteMode call WriteMode()


" Like gJ, but always remove spaces
" Mapped to <Leader>J
fun! JoinSpaceless()
	execute 'normal gJ'

	" Character under cursor is whitespace?
	if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
		" When remove it!
		execute 'normal dw'
	endif
endfun


" Clean trailing whitespace
fun! TrimWhitespace()
	let l:save_cursor = getpos('.')
	%s/\s\+$//e
	call setpos('.', l:save_cursor)
endfun
command! TrimWhitespace call TrimWhitespace()

" Reverse order of lines
command! -bar -range=% Reverse <line1>,<line2>global/^/m<line1>-1

":ScratchBuffer makes current buffer disposable
command! ScratchBuffer setlocal buftype=nofile bufhidden=hide noswapfile

" Move a file & update buffer
" TODO
" TODO: Also Cp
function! Mv(dst)
	let l:src = expand('%:p')
	if a:dst != ''
		let l:dst = expand(a:dst)
	else
		let l:dst = expand(input('New file name: ', expand('%:p'), 'file'))
	endif

	echo l:dst
	return

	if l:dst != '' && l:dst != l:src
		exec ':saveas ' . l:dst
		exec ':silent !rm ' . l:src
		redraw!
	endif
endfunction
command! -nargs=? -complete=file Mv call Mv(<q-args>)


command! -nargs=1 -complete=file WE write | edit <args>

fun CompileCoffee()
	augroup coffee
		autocmd!
		"autocmd BufWritePost *.coffee :silent !coffee -c % | :echomsg "Compiled"
		autocmd BufWritePost *.coffee silent !coffee -c %
	aug END
endfun

command! CompileCoffee call CompileCoffee()
