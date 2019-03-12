scriptencoding utf-8

syntax on                              " Switch syntax highlighting on.
filetype plugin indent on              " Enable filetype detection.
set termguicolors                      " Use true colors.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Set correct escape codes for st.
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

silent! colorscheme default2           " Load my color scheme if it exists.
if get(g:, 'colors_name', '') isnot# 'default2'
	colorscheme default                " Fall back to default (some Linuxes overwrite this in global vimrc).
endif

set backspace=indent,eol,start         " Allow backspacing over everything.
set history=500                        " Keep 500 lines of command line history.
set incsearch                          " Jump to match while typing the pattern in /.
set hlsearch                           " Highlight the last used search pattern.
set ignorecase                         " Case-insensitive searching unless \C is in the pattern...
set smartcase                          " ...or the pattern contains an upper case letter.
set nowrapscan                         " Don't wrap search.
set gdefault                           " Always use the /g flag with :s; add /g to restore the default behaviour.
set textwidth=80                       " Wrap at at 80 characters.
set linebreak                          " Wrap at word.
set breakindent                        " When wrapping show next line on the same indent level.
set autoindent                         " Always set auto indenting on.
set backup                             " Keep backup file when writing.
set backupext=.bak                     " Extension for backup files.
set listchars=tab:!·,trail:·           " String to use in 'list' mode.
set spelllang=en_gb                    " Default language for spell check.
set helplang=en                        " Always use English in help...
set langmenu=en                        " ...and UI
set scrolloff=5                        " Minimum number of lines to keep above/below cursor.
set wildmenu                           " Better tab completion at the command-line.
" set wildignore=*.o,*.pyc,*.png,*.jpg,*_test.go
set wildignore=*.o,*.pyc,*.png,*.jpg   " Ignore these files in completion.
set wildmode=list:longest              " List all matches, and complete to the longest unambiguous string.
set wildignorecase                     " Case is ignored when completing file names and directories.
set completeopt=longest,menuone        " Insert mode completion.
" set completeopt=longest,menuone,noinsert
set previewheight=6                    " Height of preview window.
set pumheight=10                       " Don't make completion menu too high.
set infercase                          " Like smartcase for insert completion.
set tabpagemax=500                     " Max. number of tabs to be open with -p argument or :tab all "
set showcmd                            " Show partial command in the last line of the screen.
set formatoptions+=j                   " j: Remove comment character when joining lines with J.
set nojoinspaces                       " Don't add two spaces after interpunction when using J.
set shiftround                         " Round indent to multiple of shiftwidth when using < and >
set smarttab                           " Backspace at start of line remove shiftwidith worth of space.
set matchpairs+=<:>                    " Also match < & > with %
set switchbuf=useopen,usetab,newtab    " Use open tab (if any) when trying to jump to a quickfix error.
" set switchbuf=usetab
set noexpandtab                        " Real men use real tabs...
set tabstop=4                          " ...which are always 4 spaces wide.
set shiftwidth=0                       " Use tabstop.
set softtabstop=-1                     " Use shiftwidth.
set synmaxcol=500                      " Maximum column in which to search for syntax items.
set t_te=                              " Prevent clearing the terminal on exit.
"set t_ti= t_te=
set mouse=                             " I don't want no stinkin' mouse (off by default in Vim, but enabled in Neovim).
set nrformats=bin,hex                  " Don't increment octal numbers.
set paragraphs=                        " Don't include nroff stuff.
set tildeop                            " Use ~ as an operator; e.g. ~w
set clipboard=                         " Never automatically interface with system clipboard.
set nofoldenable                       " Disable folds by default.
set laststatus=2                       " Always show statusline...
set showtabline=2                      " ...and tab bar.
set ttyfast                            " Faster redrawing.
set title                              " Update term title...
set titleold=                          " ...but restore old title after exiting.

set viminfo='50,<0,n~/.vim/tmp/viminfo " '50  save fewer marks.
                                       " <0   prevent saving registers.

set display=lastline,uhex              " lastline  Show as much of the last line as possible instead of @
                                       " uhex      Always show unprintable chars as <xx> instead of ^C

set updatecount=50                     " Write to swap file every 50 characters; swap file is also written if nothing
                                       " happens for four seconds (as set by the 'updatetime' setting).


set formatoptions+=ncroql              " n   Recognize numbered lists when formatting (see formatlistpat)
                                       " c   Wrap comments with textwidth
                                       " r   Insert comment char after enter
                                       " o   Insert comment char after o/O
                                       " q   Format comments with gq
                                       " l   Do not break lines when they were longer than 'textwidth' to start with

" ... make it deal with non-numbered lists (-) as well
set formatlistpat=^\\s*\\(\\d\\\|\-\\)\\+[\\]:.)}\\t\ ]\\s*

set backupdir=$HOME/.vim/tmp/backup    " Set/create directory to keep backup, swap, and undo files.
set directory=$HOME/.vim/tmp/swap
set viewdir=$HOME/.vim/tmp/view
set undodir=$HOME/.vim/tmp/undo
if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&directory) | call mkdir(&directory, 'p', 0700) | endif
if !isdirectory(&viewdir)   | call mkdir(&viewdir, 'p', 0700)   | endif
if !isdirectory(&undodir)   | call mkdir(&undodir, 'p', 0700)   | endif

set statusline=                        " Set my statusline.
let &statusline .= '%<%f'              " Filename, truncate right
let &statusline .= ' %h%m%r'           " [Help] [modified] [read-only]
"let &statusline .= '%{len(getloclist(0)) > 0 ? "[E]" : ""}'

let &statusline .= '%='                " Right-align from here on.
let &statusline .= ' %{get(v:completed_item, "abbr", "")}'
let &statusline .= ' [line %l of %L]'  " current line, total lines.
let &statusline .= ' [col %v]'         " column.
let &statusline .= ' [0x%B]'           " Byte value under cursor.

let &rulerformat = '%l/%L %c 0x%B'     " Width is 17 characters.

" Highlight columns 80/120
fun! s:color()
	highlight SoftWrap cterm=underline gui=underline
	highlight HardWrap ctermbg=225 guibg=lightred
endfun
call s:color()
augroup softwrap
	autocmd!
	autocmd Colorscheme * call s:color()

	" I don't know why this needs to be in this autocmd, but sometimes it won't
	" work if it's not.
	autocmd BufReadPost,BufNew *
		\  call matchadd('SoftWrap', '\%82v')
		\| call matchadd('HardWrap', '\%122v')
augroup end
