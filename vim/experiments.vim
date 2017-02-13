" $dotid$

fun! SelectCode() abort
	if getline('.')[0] != "\t"
		return 'ap'
	endif

	call search("[^\t]\n\t", 'b')
	

	"normal o
	"call search('^$')
	return ""
endfun

" Run shell command with \c on visual selection
" TODO: Pluginify
xnoremap <expr> <Leader>c "\<Esc>:'<,'>:w !" . getbufvar('%', 'run_command', &filetype) . "\<CR>"

" Show line number relative to the cursor
"set relativenumber

" Don't reserve any space for the number column
"set numberwidth=1

" Allow ~ to be used as an operator
set tildeop

" Not so bright
hi LineNr ctermfg=253
hi CursorLineNr ctermfg=253
