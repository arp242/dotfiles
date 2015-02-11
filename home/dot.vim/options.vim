" Use Vim settings, rather then Vi settings
set nocompatible

" Allow backspacing over everything
set backspace=indent,eol,start

" Keep n lines of command line history
set history=500

" Show the ruler all the time
set ruler

" %40 - 40 wide
" %= Right align
" %l line num of cursor
" %L Total lines in buf
" %c column of cursor
" %o Byte pos of cursor
" %B Byte value under cursor
set rulerformat=%40(%=[line\ %l\ of\ %L]\ [c:%c\ p:%o\ 0x%B]%)

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

" set 'text width' to 80 characters.
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

" '500  - Remember 500 marks
" <500 - Save 500 lines for each register
" :500  - Remember 500 items in commandline history
" %     - Remember buffer List 
set viminfo='500,:500,%,<500,s10

" Use UTF-8 by default
set encoding=utf-8

" Always use \n
set fileformats=unix

" Faster redrawing
set ttyfast

" Update term title
set title

" Restore old title after leaving Vim
set titleold=

" Use blowfish2 for encrypting files; blowfish is *not* secure
if has("cryptv") && has("patch-7.4-399")
	set cryptmethod=blowfish2
endif

" Show as much of the last line as possibe instead of @
" Show unprintable chars as <xx>
set display=lastline,uhex

" Write to swap file every 50 characters
set updatecount=50

" Min num of lines to keep above/below cursor
set scrolloff=5

" Better tab completion at the Vim cmd
set wildmenu

" Ignore these files in completion
set wildignore=*.o,*.pyc,*.png,*.jpg

" List all matches, only complete when it's unambigious
set wildmode=list:longest,full

" Insert mode completion
set completeopt=longest,menu

" Allow cursor to go one character past the end of the line
set virtualedit=onemore

" Max. number of tabs to be open with -p argument or :tab all"
set tabpagemax=50

" Show partial command in the last line of the screen
set showcmd

" j: Remove comment character when joining lines with J
set formatoptions+=j

" Round indent to multiple of shiftwidth when using < and >
set shiftround

" Backspace at start of line remove shiftwidith worth of space
set smarttab

" Also match < & > with %
set matchpairs+=<:>

" Persistent undo
if has('persistent_undo')
	set undofile
endif

if executable('ag')
	set grepprg="ag --nogroup --nocolor"
endif

" Tab settings
set noexpandtab
set ts=4
set sw=4
set sts=4

" Only use UNIX line endings
set fileformats=unix

" Set (& create if needed) a temp directory to keep backup & swap files
if has('win32')
	let whoami = substitute(system("whoami /LOGONID"), '\n', '', '')
	let tmpdir = 'C:/tmp/vim_' . whoami
else
	let whoami = substitute(system("whoami"), '\n', '', '')
	let tmpdir = '/var/tmp/vim_' . whoami
endif
call MkdirIfNeeded(tmpdir, 'p', 0700)

let &backupdir = tmpdir
let &dir = tmpdir
if has('persistent_undo')
	let &undodir = tmpdir
endif

" Switch syntax highlighting on
syntax on

" Use standard color scheme (some Linuxes feel the need to overwrite this in
" global vimrc)
colorscheme default

" My terminal has a white background colour
set background=light

" 16 colors are enough
set t_Co=16

" Prevent clearing the terminal on exit
set t_te=

" Enable file type detection
filetype plugin indent on

" Syntastic plugin
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1

" localvimrc
let g:localvimrc_whitelist = '/home/martin/code/.lvimrc'
