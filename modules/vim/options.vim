" $dotid"

" Set the encoding of this file
scriptencoding utf-8

" Use Vim defaults, rather then Vi defaults
set nocompatible

" Allow backspacing over everything; http://vi.stackexchange.com/a/2163/51
set backspace=indent,eol,start

" Keep n lines of command line history
set history=500

" Jump to search word while typing
set incsearch

" Highlight the last used search pattern.
set hlsearch

" Case-insensitive searching ...
set ignorecase

" ... unless the patern contains upper case letters
set smartcase

" Don't wrap search
set nowrapscan

" Add the /g flag to :s command; add /g manually to restore the default
" behaviour ...
set gdefault

" Set 'text width' to 80 characters.
set textwidth=80

" Show a █ when wrapping a line
set showbreak=█

" Wrap at word
set linebreak

" Always set auto indenting on
set autoindent

" Keep backup file when writing
set backup

" Extension for backup files
set backupext=.bak

" String to use in 'list' mode
" Using · only seems to work only in fairly recent Vim versions
if v:version > 703
	set listchars=tab:!·,trail:·
else
	set listchars=tab:!.,trail:.
endif

" Default language for spell check
set spelllang=en_gb

" Always use English in UI/help
set helplang=en
set langmenu=en

" Disable folds
set nofoldenable

" Always show tab bar at top
set showtabline=2

" Always show statusline
set laststatus=2

" ! Remember variables that are in ALL CAPS
set viminfo+=!

" Use utf-8
set encoding=utf-8

" Always use UNIX line endings \n
set fileformats=unix

" Faster redrawing
set ttyfast

" Update term title...
set title

" ...but restore old title after leaving Vim
set titleold=

" This will timeout only on key codes, and not mappings
"set notimeout
"set ttimeout

" Use blowfish2 for encrypting files; blowfish is *not* secure
if has("cryptv") && has("patch-7.4-399")
	set cryptmethod=blowfish2
endif

" lastline: Show as much of the last line as possible instead of @
" uhex: Show unprintable chars as <xx>
set display=lastline,uhex

" Write to swap file every 50 characters
set updatecount=50

" Minimum number of lines to keep above/below cursor
set scrolloff=5

" Better tab completion at the Vim cmd
set wildmenu

" Ignore these files in completion
set wildignore=*.o,*.pyc,*.png,*.jpg

" List all matches, and complete to the longest unambiguous string
set wildmode=list:longest

" Insert mode completion
set completeopt=longest,menu

" Allow cursor to go one character past the end of the line
set virtualedit=onemore

" Max. number of tabs to be open with -p argument or :tab all"
set tabpagemax=50

" Show partial command in the last line of the screen
set showcmd

" n: Recognize numbered lists when formatting ...
set formatoptions+=n

" ... make it deal with non-numbered lists (-) as well
set formatlistpat=^\\s*\\(\\d\\\|\-\\)\\+[\\]:.)}\\t\ ]\\s*

" j: Remove comment character when joining lines with J
if v:version > 703
	set formatoptions+=j
endif

" Interactively ask for confirmation when the buffer is unsaved & quiting
set confirm

" Round indent to multiple of shiftwidth when using < and >
set shiftround

" Backspace at start of line remove shiftwidith worth of space
set smarttab

" Also match < & > with %
set matchpairs+=<:>

" Use real tabs...
set noexpandtab

" ...which are always 4 spaces wide
set ts=4
set sw=4
set sts=4

" Only use UNIX line endings
set fileformats=unix

" Set (& create if needed) a temp directory to keep backup & swap files
set backupdir=$HOME/.vim/tmp/backup
set dir=$HOME/.vim/tmp/
call MkdirIfNeeded(&backupdir, 'p', 0700)

if has('persistent_undo')
	set undodir=$HOME/.vim/tmp/undo
	call MkdirIfNeeded(&undodir, 'p', 0700)
endif

" Switch syntax highlighting on
syntax on

" Use standard color scheme (some Linuxes feel the need to overwrite this in
" global vimrc)
colorscheme default

" My terminal has a white background colour
set background=light

" Prevent clearing the terminal on exit
set t_te=

" Use ^? as the backspace, and not ^H
"set t_kb=

" Enable file type detection
filetype plugin indent on

""" Netrw
" Use whole "words" when opening URLs.
" " This avoids cutting off parameters (after '?') and anchors (after '#'). 
" " See http://vi.stackexchange.com/q/2801/1631
let g:netrw_gx="<cWORD>"    

"""" Syntastic plugin
" Open & check by default
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" The default of -W2 is too verbose
let g:syntastic_ruby_mri_args = "-W1 -T1"

" Use the Bourne shell, and not tcsh
let g:syntastic_shell = "/bin/sh"


""" indentLine
" Don't enable by default
let g:indentLine_enabled = 0

" Use UTF-8 boxdrawing character; looks lots better than ugly ASCII |
let g:indentLine_char = '│'


""" vim-ruby
" Indent functions after a private/protected/public one more
let g:ruby_indent_access_modifier_style = 'indent'

" Do spell checking in strings
let ruby_spellcheck_strings = 1

"let g:ctrlp_by_filename = 1
"let g:ctrlp_match_func = {}
let g:ctrlp_custom_ignore = { 'dir': '\v(spec|cache)' }

" Parse ruby code for autocomplete; only for specific files
" Not a buffer-variable, so not 100% safe...
au BufNewFile,BufRead /home/martin/code/*
	\ let g:rubycomplete_buffer_loading = 1 |
	\ let g:rubycomplete_rails = 1 |
    \ let g:rubycomplete_load_gemfile = 1
