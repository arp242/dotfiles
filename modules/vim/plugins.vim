" Setup runtimepath
execute pathogen#infect('bundle/{}', '~/vim/{}')

" YAPM
" Yapm 'bb://Carpetsmoker/yapl'
" 
" " Interpret colour escape codes (:AnsiEsc)
" Yapm 'script://302'
" 
" " Useful unicode related stuff (:SearchUnicode, :UnicodeName)
" Yapm 'https://github.com/chrisbra/unicode.vim.git'
" 
" " Align stuff
" Yapm 'gh://godlygeek/tabular'
" 
" " Lint Vim help files
" Yapm 'gh://machakann/vim-vimhelplint'
" 
" " Set performance options for large files (:Large, :Unlarge)
" Yapm 'script://1506'
" 
" " Easy visual undo tree (:UndotreeToggle or <F3>)
" Yapm 'gh://mbbill/undotree'
" 
" " Make it easy to make ASII tables (:TableModeToggle)
" Yapm 'gh://dhruvasagar/vim-table-mode'


" https://github.com/justinmk/vim-sneak
" https://github.com/gioele/vim-autoswap


" Warn on syntax errors (enabled by default, disable with :SyntasticToggleMode
" or <F4>)
" TODO: This broke...
"Plug 'scrooloose/syntastic'

" Plug 'groenewege/vim-less'        " LessCSS
" Plug 'hail2u/vim-css3-syntax'     " Knows moar CSS rules
" Plug 'kchmck/vim-coffee-script'   " CoffeeScipt
" Plug 'rodjek/vim-puppet'          " Puppet
" Plug 'slim-template/vim-slim'     " Slim templates
" Plug 'vim-ruby/vim-ruby'          " Better ruby motions, completions
" 
" let prefix = isdirectory('/home/martin/vim/startscreen.vim') ? '~/vim' : 'vim-scripts'
" Plug prefix . '/auto_autoread.vim'
" Plug prefix . '/autoswap_session.vim'
" Plug prefix . '/complete_email.vim'
" Plug prefix . '/helplink.vim'
" Plug prefix . '/powersearch.vim'
" Plug prefix . '/startscreen.vim'
" Plug prefix . '/undofile_warn.vim'
" Plug prefix . '/write_help.vim'
" Plug prefix . '/xdg-open.vim'

"Plug prefix . '/confirm_quit.vim'
"Plug prefix . '/helpline.vim'
"Plug prefix . '/mkdir.vim'
"Plug prefix . '/multitabs.vim'
"Plug prefix . '/sane_braces.vim'


" Disable some of the default plugins that we don't use.
let g:loaded_getscriptPlugin = 1
let g:loaded_netrwPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_confirm_quit = 1

" We don't use the menus (this is comparatively slow)
let g:did_install_default_menus = 1

" Expanded % functionality
runtime macros/matchit.vim

" Consider it to be a "large" file is larger than this amount of MB
let g:LargeFile = 10

let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" The default of -W2 is too verbose
let g:syntastic_ruby_mri_args = "-W1 -T1"

" Use the Bourne shell, and not tcsh
let g:syntastic_shell = "/bin/sh"

" We need this to prevent the unicode plugin from overriding it
nnoremap <F13> <Plug>(MakeDigraph) | vnoremap <F13> <Plug>(MakeDigraph)


""""""""""""""""""
"""" Filetypes """
""""""""""""""""""
" Indent functions after a private/protected/public one more
let g:ruby_indent_access_modifier_style = 'indent'

" Do spell checking in strings
let ruby_spellcheck_strings = 1

" Parse ruby code for autocomplete; only for specific files
" Not a buffer-variable, so not 100% safe...
au BufNewFile,BufRead /home/martin/code/*
	\ let g:rubycomplete_buffer_loading = 1 |
	\ let g:rubycomplete_rails = 1 |
    \ let g:rubycomplete_load_gemfile = 1


" Set my statusline
set statusline=

" Left part
let &stl .= '${InsertEnter,InsertLeave helpline#color2("StatusLine", "Search")}'

let &stl .= '%<%f'                " Filename, truncate right
let &stl .= ' %h%m%r'             " [Help] [modified] [read-only]
let &stl .= '%='                  " Right-align from here on

" Right
let &stl .= ' [line %l of %L]'    " current line, total lines
let &stl .= ' [col %c]'           " column
let &stl .= ' [0x%B]'             " Byte value under cursor

"let &stl .= '${InsertEnter,InsertLeave system("date +%%H:%%m:%%S")[:-2]}'

"let &stl .= '[${InsertEnter system("date")[:-2]}]'
"let &stl .= '(${InsertLeave system("date")[:-2]})'
"call helpline#tokenize_statusline()
