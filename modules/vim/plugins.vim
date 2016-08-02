" $dotid: 96$

" Disable some of the default plugins that we don't use.
let g:loaded_getscriptPlugin = 1
let g:loaded_netrwPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

" We don't use the menus (this is comparatively slow)
let g:did_install_default_menus = 1

" My plugins that I don't need
let g:loaded_confirm_quit = 1

" Expanded % functionality
runtime macros/matchit.vim


" unicode: prevent overriding thing mapping 
nnoremap <F13> <Plug>(MakeDigraph) | vnoremap <F13> <Plug>(MakeDigraph)

" LargeFile: consider it to be a "large" file is larger than this amount of MB
let g:LargeFile = 10

" Syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" The default of -W2 is too verbose
let g:syntastic_ruby_mri_args = "-W1 -T1"

"" Use the Bourne shell, and not tcsh
let g:syntastic_shell = "/bin/bash"

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"autocmd BufReadPost /home/martin/code/src/github.com/teamwork/TeamworkDesk/*.go let g:syntastic_go_checkers = ['govet', 'errcheck']

"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }


" Set my statusline
fun s:set_stl()
	set statusline=

	" Left part
	"let &stl .= '${InsertEnter,InsertLeave helpline#color2("StatusLine", "Search")}'

	let &stl .= '%<%f'                " Filename, truncate right
	let &stl .= ' %h%m%r'             " [Help] [modified] [read-only]
	let &stl .= '%='                  " Right-align from here on

	" Right/ruler
	if &ft == 'go'
		setlocal updatetime=800
		call helpline#define_color('grey', 'ctermbg=0 ctermfg=251 cterm=bold')
		"highlight StatuslineGrey ctermbg=0 ctermfg=251 cterm=bold
		"autocmd ColorScheme *
		"	\ highlight StatuslineGrey ctermbg=0 ctermfg=251 cterm=bold

		"let &stl .= "@{grey ${CursorHold go#complete#GetInfo()}}"
		let &stl .= "%#Helpline_grey#${CursorHold go#complete#GetInfo()}%#Statusline#"
	endif
	let &stl .= ' [line %l of %L]'    " current line, total lines
	let &stl .= ' [col %v]'           " column
	let &stl .= ' [0x%B]'             " Byte value under cursor

	" Width is 17 characters
	let &rulerformat = '%l/%L %c 0x%B'

	"let &stl .= '${InsertEnter,InsertLeave system("date +%%H:%%m:%%S")[:-2]}'

	"let &stl .= '[${InsertEnter system("date")[:-2]}]'
	"let &stl .= '(${InsertLeave system("date")[:-2]})'
	call helpline#process()
endfun
autocmd Filetype * call s:set_stl()


" Check these out, maybe
" https://github.com/gioele/vim-autoswap
" https://github.com/justinmk/vim-sneak
" https://github.com/machakann/vim-vimhelplint
" https://guthub.com/godlygeek/tabular
