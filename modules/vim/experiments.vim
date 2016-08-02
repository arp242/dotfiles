" $dotid: 92$

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
