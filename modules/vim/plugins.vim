" $dotid$

" Disable some of the default plugins that we don't use.
let g:loaded_getscriptPlugin = 1
let g:loaded_netrwPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1
" We don't use the menus (this is comparatively slow)
let g:did_install_default_menus = 1

" Expanded % functionality
runtime macros/matchit.vim

" Setup VAM
fun! s:setup_vam()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp .= (empty(&rtp) ? '' : ',') . c.plugin_root_dir . '/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir . '/vim-addon-manager/autoload')
	" TODO: Check if git exists
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
    	\ shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call s:setup_vam()


""" Interpret colour escape codes (:AnsiEsc)
VAMActivate	AnsiEsc


""" Useful unicode related stuff (:SearchUnicode, :UnicodeName)
VAMActivate unicode
" We need this to prevent the unicode plugin from overriding it
nnoremap <F13> <Plug>(MakeDigraph) | vnoremap <F13> <Plug>(MakeDigraph)


""" Set performance options for large files (:Large, :Unlarge)
VAMActivate LargeFile
" Consider it to be a "large" file is larger than this amount of MB
let g:LargeFile = 10

""" Make it easy to make ASII tables (:TableModeToggle)
VAMActivate table-mode


""" Warn on syntax errors (enabled by default, disable with <F4>)
VAMActivate github:scrooloose/syntastic
let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" The default of -W2 is too verbose
let g:syntastic_ruby_mri_args = "-W1 -T1"

" Use the Bourne shell, and not tcsh
let g:syntastic_shell = "/bin/bash"


""" Various filetypes
VAMActivate vim-less@groenwege vim-css3-syntax vim-coffee-script

" Load my own plugins
if isdirectory('/home/martin/vim/startscreen.vim')
	let g:loaded_confirm_quit = 1
	call vam#Scripts([{'activate_this_rtp': '~/vim/*'}], {})
endif

VAMActivate vim-go
"VAMActivate neocomplete
"VAMActivate neocomplcache
VAMActivate github:majutsushi/tagbar
"VAMActivate github:garyburd/go-explorer

" Set my statusline
set statusline=

" Left part
"let &stl .= '${InsertEnter,InsertLeave helpline#color2("StatusLine", "Search")}'

let &stl .= '%<%f'                " Filename, truncate right
let &stl .= ' %h%m%r'             " [Help] [modified] [read-only]
let &stl .= '%='                  " Right-align from here on

" Right/ruler
let &stl .= ' [line %l of %L]'    " current line, total lines
let &stl .= ' [col %c]'           " column
let &stl .= ' [0x%B]'             " Byte value under cursor

" Width is 17 characters
let &rulerformat = '%l/%L %c 0x%B'

"let &stl .= '${InsertEnter,InsertLeave system("date +%%H:%%m:%%S")[:-2]}'

"let &stl .= '[${InsertEnter system("date")[:-2]}]'
"let &stl .= '(${InsertLeave system("date")[:-2]})'
"call helpline#tokenize_statusline()


" Check these out, maybe
" https://github.com/gioele/vim-autoswap
" https://github.com/justinmk/vim-sneak
" https://github.com/machakann/vim-vimhelplint
" https://guthub.com/godlygeek/tabular
