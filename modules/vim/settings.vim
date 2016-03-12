" Set the encoding of this file
scriptencoding utf-8

" Allow backspacing over everything
set backspace=indent,eol,start

" Keep n lines of command line history
set history=500

" - '50 to save fewer marks
" - <0 to prevent saving registers
if has('nvim')
	set viminfo='50,<0,s10,h,n~/.vim/tmp/viminfo.nvim
else
	set viminfo='50,<0,s10,h,n~/.vim/tmp/viminfo
endif

" Jump to search word while typing
set incsearch

" Highlight the last used search pattern.
set hlsearch

" Case-insensitive searching unless the pattern contains an upper case letter or
" if \C is in the pattern.
set ignorecase
set smartcase

" Don't wrap search
set nowrapscan

" Always use the /g flag with :s; add /g to restore the default behaviour.
set gdefault

" Wrap at at 80 characters
set textwidth=80

" Wrap at word
set linebreak

" Show a █ when wrapping a line
set showbreak=█

" When wrapping show next line on the same indent level
if has('patch-7.4.338') | set breakindent | endif

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

" Disable folds by default
set nofoldenable

" Always show statusline and tab bar
set laststatus=2
set showtabline=2

" Use utf-8
set encoding=utf-8

" Always use UNIX line endings \n
set fileformats=unix

" Faster redrawing
set ttyfast

" Update term title but restore old title after leaving Vim
set title
set titleold=

" Use blowfish2 for encrypting files; blowfish is *not* secure
if has('cryptv') && has('patch-7.4-399') | set cryptmethod=blowfish2 | :endif

" lastline: Show as much of the last line as possible instead of @
" uhex: Always show unprintable chars as <xx> instead of ^C
set display=lastline,uhex

" Write to swap file every 50 characters
set updatecount=50

" Minimum number of lines to keep above/below cursor
set scrolloff=5

" Better tab completion at the command-line
set wildmenu

" Ignore these files in completion
set wildignore=*.o,*.pyc,*.png,*.jpg

" List all matches, and complete to the longest unambiguous string
set wildmode=list:longest

" Case is ignored when completing file names and directories
set wildignorecase

" Insert mode completion
set completeopt=longest,menu

" Allow cursor to go one character past the end of the line
"set virtualedit=onemore

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
"set confirm

" Round indent to multiple of shiftwidth when using < and >
set shiftround

" Backspace at start of line remove shiftwidith worth of space
set smarttab

" Also match < & > with %
set matchpairs+=<:>

" Real men use real tabs...
set noexpandtab

" ...which are always 4 spaces wide
set ts=4
set sw=4
set sts=4

" Set (& create if needed) a temp directory to keep backup & swap files
set backupdir=$HOME/.vim/tmp/backup
set dir=$HOME/.vim/tmp/swap
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

if has('persistent_undo')
	set undodir=$HOME/.vim/tmp/undo
	if !isdirectory(&undodir) | call mkdir(&undodir, 'p', 0700) | endif
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

" Don't make completion menu too high
set pumheight=10

" Enable file type detection
filetype plugin indent on

if has('nvim')
	set mouse=
endif
