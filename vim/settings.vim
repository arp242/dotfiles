" Switch syntax highlighting on
syntax on

" Enable file type detection
filetype plugin indent on

" Use true colors.
set termguicolors
" Set correct escape codes for st.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Load my color scheme if it exists.
silent! colorscheme default2

" Use standard color scheme (some Linuxes feel the need to overwrite this in
" global vimrc)
if get(g:, 'colors_name', 'default2') isnot# 'default2'
	colorscheme default
endif

" My terminal has a white background colour
set background=light

" Allow backspacing over everything
set backspace=indent,eol,start

" Keep 500 lines of command line history
set history=500

" '50  save fewer marks
" <0   prevent saving registers
"
" Neovim also has a different viminfo format, so store that somewhere else
set viminfo='50,<0,n~/.vim/tmp/viminfo
if has('nvim')
	let &viminfo .= '.nvim'
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
"set showbreak=█

" When wrapping show next line on the same indent level
if has('patch-7.4.338')
	set breakindent
endif

" Always set auto indenting on
set autoindent

" Keep backup file when writing
set backup

" Extension for backup files
set backupext=.bak

" String to use in 'list' mode
" Using · only seems to work only in fairly recent Vim versions
if v:version > 703
	silent! set listchars=tab:!·,trail:·
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

" Always use UNIX line endings \n
"set fileformats=unix

" Faster redrawing
set ttyfast

" Update term title but restore old title after leaving Vim
set title
set titleold=

" Use blowfish2 for encrypting files; cryptmethod=blowfish is *not* secure
if has('cryptv') && has('patch-7.4-399')
	set cryptmethod=blowfish2
endif

" lastline  Show as much of the last line as possible instead of @
" uhex      Always show unprintable chars as <xx> instead of ^C
set display=lastline,uhex

" Write to swap file every 50 characters; swap file is also written if nothing
" happens for four seconds (as set by the 'updatetime' setting)
set updatecount=50

" Minimum number of lines to keep above/below cursor
set scrolloff=5

" Better tab completion at the command-line
set wildmenu

" Ignore these files in completion
"set wildignore=*.o,*.pyc,*.png,*.jpg,*_test.go
set wildignore=*.o,*.pyc,*.png,*.jpg

" List all matches, and complete to the longest unambiguous string
set wildmode=list:longest

" Case is ignored when completing file names and directories
set wildignorecase

" Insert mode completion
set completeopt=longest,menuone
"set completeopt=longest,menuone,noinsert

" Don't make completion menu too high
set pumheight=10

" Like smartcase for insert completion
set infercase

" Allow cursor to go one character past the end of the line
"set virtualedit=onemore

" Max. number of tabs to be open with -p argument or :tab all"
set tabpagemax=50

" Show partial command in the last line of the screen
set showcmd

" n   Recognize numbered lists when formatting (see formatlistpat)
" c   Wrap comments with textwidth
" r   Insert comment char after enter
" o   Insert comment char after o/O
" q   Format comments with gq
" l   Do not break lines when they were longer than 'textwidth' to start with
set formatoptions+=ncroql

" ... make it deal with non-numbered lists (-) as well
set formatlistpat=^\\s*\\(\\d\\\|\-\\)\\+[\\]:.)}\\t\ ]\\s*

" j: Remove comment character when joining lines with J
if v:version > 703
	set formatoptions+=j
endif

" Don't add two spaces after interpunction when using J
set nojoinspaces

" Interactively ask for confirmation when the buffer is unsaved & quiting
"set confirm

" Round indent to multiple of shiftwidth when using < and >
" Note that this can break some badly indented code when re-indenting whole
" blocks
set shiftround

" Backspace at start of line remove shiftwidith worth of space
set smarttab

" Also match < & > with %
set matchpairs+=<:>

" Use open tab (if any) when trying to jump to a quickfix error.
set switchbuf=usetab

" Real men use real tabs...
set noexpandtab

" ...which are always 4 spaces wide
set tabstop=4
set shiftwidth=0    " Use tabstop
set softtabstop=-1  " Use shiftwidth

" Set (& create if needed) a temp directory to keep backup, swap, and undo files
set backupdir=$HOME/.vim/tmp/backup
set directory=$HOME/.vim/tmp/swap
set viewdir=$HOME/.vim/tmp/view
set undodir=$HOME/.vim/tmp/undo
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&directory) | call mkdir(&directory, 'p', 0700) | endif
if !isdirectory(&viewdir)   | call mkdir(&viewdir, 'p', 0700)   | endif
if !isdirectory(&undodir)   | call mkdir(&undodir, 'p', 0700)   | endif

" Maximum column in which to search for syntax items.
set synmaxcol=500

" Prevent clearing the terminal on exit
"set t_ti= t_te=
set t_te=

" I don't want no stinkin' mouse (off by default in Vim, but enabled in Neovim)
set mouse=

" Don't increment octal numbers
set nrformats=bin,hex

" Don't include nroff stuff
set paragraphs=

" Use ~ as an operator; e.g. ~w
set tildeop

" Never automatically interface with system clipboard.
set clipboard=

" Use ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Set my statusline.
let g:ale_linting = 0
let g:ale_fixing = 0
let g:making = 0
augroup ALEProgress
    autocmd!
    autocmd User ALELintPre   let g:ale_linting = 1 | redrawstatus
    autocmd User ALELintPost  let g:ale_linting = 0 | redrawstatus
    autocmd User ALEFixPre    let g:ale_fixing = 1  | redrawstatus
    autocmd User ALEFixPost   let g:ale_fixing = 0  | redrawstatus
	autocmd QuickFixCmdPre  * let g:making = 1      | redrawstatus
	autocmd QuickFixCmdPost * let g:making = 0      | redrawstatus
augroup end

set statusline=
let &statusline .= '%<%f'                " Filename, truncate right
let &statusline .= ' %h%m%r'             " [Help] [modified] [read-only]
let &statusline .= '%{g:ale_linting ? "[L]" : ""}'
let &statusline .= '%{g:ale_fixing  ? "[F]" : ""}'
let &statusline .= '%{g:making      ? "[M]" : ""}'
let &statusline .= '%#Error#%{len(getloclist(0)) > 0 ? "[E]" : ""}%#StatusLine#'
if exists('*go#statusline#Show()')
	let &statusline .= '%{go#statusline#Show()}'
endif
"let &statusline .= ' %#StatusLineGray#%{LastComplete()}%#StatusLine#'

" Right/ruler
let &statusline .= '%='                  " Right-align from here on
let &statusline .= ' [line %l of %L]'    " current line, total lines
let &statusline .= ' [col %v]'           " column
let &statusline .= ' [0x%B]'             " Byte value under cursor

" Width is 17 characters
let &rulerformat = '%l/%L %c 0x%B'
