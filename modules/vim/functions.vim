" $dotid$

" Make directory if it doesn't exist yet
fun! MkdirIfNeeded(dir, flags, permissions)
	if !isdirectory(a:dir)
		call mkdir(a:dir, a:flags, a:permissions)
	endif
endfun


" Replace `} else {' with `}\nelse {'
" This is sane, because the if/else line up
fun! IndentSane()
	let l:save_cursor = getpos(".")   
	silent! %s/\v(\s*)}\s*(else|catch)/\1}\r\1\2/e
	call setpos('.', l:save_cursor)   
endfun
command! IndentSane call IndentSane()


" Replace `}\nelse {' with `} else {'
" This is retarded, because the if/else don't line up
fun! IndentRetarded()
	let l:save_cursor = getpos(".")   
	silent! %s/\v}\_.(\s*)(else|catch)/} \2/e
	call setpos('.', l:save_cursor)   
endfun
command! IndentRetarded call IndentRetarded()


" Open multiple tabs at once
fun! OpenMultipleTabs(pattern_list)
	for p in a:pattern_list
		for c in glob(l:p, 0, 1)
			execute 'tabedit ' . l:c
		endfor
	endfor
endfun
command! -bar -bang -nargs=+ -complete=file Tabedit call OpenMultipleTabs([<f-args>])


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


" Make help link (markdown format)
" TODO: Find all tags, and let the user choose which one to use
fun! Helplink()
	" Get the name of the tag, With help from:
	" https://vi.stackexchange.com/questions/434/get-name-of-nearest-tag-to-the-cursor
	if !search('\*\zs[^*]\+\*$', 'bW')
		echoerr "No tag found"
	endif
	let l:line = getline('.')
	let l:start = col('.') - 1
	call search('\*', '', line('.'))
	let l:len =  col('.') - l:start - 1
	let l:tagname = strpart(l:line, l:start, l:len)

	"map <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

	let l:tagname_esc = system('echo -n ' . shellescape(l:tagname) . ' | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()), end=' . "''" . ')"')
	let l:file = split(expand('%'), '/')[-1]
	let l:url = "http://vimhelp.appspot.com/" . l:file . ".html#" . l:tagname_esc
	let l:md = '[`:help ' . l:tagname . '`](' . l:url . ')'

	" Copy it to the clipboard
	let @+ = l:md

	return l:md
endfun


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
	nnoremap <buffer><silent> o :enew <bar> startinsert<CR>
endfun


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
fun! TrimWhiteSpace()
	let l:save_cursor = getpos(".")   
	silent! %s/\s\+$//e
	call setpos('.', l:save_cursor)   
endfun
command! TrimWhitespace call TrimWhiteSpace()

" Reverse order of lines
command! -bar -range=% Reverse <line1>,<line2>global/^/m<line1>-1
