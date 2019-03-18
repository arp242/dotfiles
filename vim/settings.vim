scriptencoding utf-8

set packpath^=~/.cache/vim             " Use ~/.cache so we can easy copy ~/.vim without loads of stuff.
syntax on                              " Switch syntax highlighting on.
filetype plugin indent on              " Enable filetype detection.
set termguicolors                      " Use true colors.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Set correct escape codes to make termguicolors
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " work in st.

silent! colorscheme default2           " Load my color scheme if it exists.
if get(g:, 'colors_name', '') isnot# 'default2'
    colorscheme default                " Fall back to default (some Linuxes overwrite this in global vimrc).
endif

set background=light                   " Make sure correct value is used.
set backspace=indent,eol,start         " Allow backspacing over everything.
set history=500                        " Keep 500 lines of command line history.
set incsearch                          " Jump to match while typing the pattern in /.
set hlsearch                           " Highlight the last used search pattern.
set ignorecase                         " Case-insensitive searching unless \C is in the pattern...
set smartcase                          " ...or the pattern contains an upper-case letter.
set nowrapscan                         " Don't wrap search.
set gdefault                           " Always use the /g flag with :s; add /g to restore the default behaviour.
set textwidth=80                       " Wrap at at 80 characters.
set linebreak                          " Wrap at word.
set showbreak=↪                        " Display at the start of line for wrapped lines.
set breakindent                        " When wrapping show next line on the same indent level.
set breakindentopt=sbr                 " Display showbreak before indent.
set autoindent                         " Copy indent from current line when starting a new line.
set backup                             " Keep backup file when writing.
set backupext=.bak                     " Extension for backup files
set listchars=tab:!·,trail:·           " String to use in 'list' mode.
set spelllang=en_gb                    " Default language for spell check.
set helplang=en                        " Always use English in help...
set langmenu=en                        " ...and UI.
set scrolloff=5                        " Minimum number of lines to keep above/below cursor.
set wildmenu                           " Better tab completion at the command-line.
set wildmode=longest,list,full         " Complete longest match, list other matches and select those with wildmenu.
set wildignore=*.o,*.pyc,*.png,*.jpg   " Ignore these files in completion.
set wildignorecase                     " Case is ignored when completing file names and directories.
set completeopt=longest,menuone        " Insert mode completion
                                       " longest: only insert longest common text instead of full match.
                                       " menuone: always show menu, even when there is 1 match.
set previewheight=6                    " Height of preview window.
set pumheight=10                       " Don't make completion menu too high.
set infercase                          " Like smartcase for insert completion.
set tabpagemax=500                     " Max. number of tabs to be open with -p argument or :tab all "
set showcmd                            " Show partial command in the last line of the screen.
set formatoptions+=j                   " Remove comment character when joining lines with J.
set nojoinspaces                       " Don't add two spaces after interpunction when using J.
set shiftround                         " Round indent to multiple of shiftwidth when using < and >
set smarttab                           " Backspace at start of line remove shiftwidith worth of space.
set matchpairs+=<:>                    " Also match < & > with %.
set switchbuf=useopen,usetab,newtab    " Use open tab (if any) when trying to jump to a quickfix error.
set noexpandtab                        " Real men use real tabs...
set tabstop=4                          " ...which are always 4 spaces wide.
set shiftwidth=0                       " Use tabstop.
set softtabstop=-1                     " Use shiftwidth.
set synmaxcol=500                      " Maximum column in which to search for syntax items.
set t_ti= t_te=                        " Prevent clearing the terminal on exit.
set mouse=                             " I don't want no stinkin' mouse (off by default in Vim, but enabled in Neovim).
set nrformats=bin,hex                  " Don't increment octal numbers.
set paragraphs=                        " Don't include nroff stuff.
set tildeop                            " Use ~ as an operator to switch case.
set clipboard=                         " Never automatically interface with system clipboard.
set nofoldenable                       " Disable folds by default.
set laststatus=2                       " Always show statusline...
set showtabline=2                      " ...and tab bar.
set title                              " Update term title...
set titleold=                          " ...but restore old title after exiting.
set display=lastline,uhex              " lastline  Show as much of the last line as possible instead of @.
                                       " uhex      Always show unprintable chars as <xx> instead of ^C.
set updatecount=50                     " Write to swap file every 50 characters; swap file is also written if nothing
                                       " happens for 4 seconds (as set by the 'updatetime' setting).
set formatoptions+=ncroql              " n   Recognize numbered lists when formatting (see formatlistpat)
                                       " c   Wrap comments with textwidth
                                       " r   Insert comment char after enter
                                       " o   Insert comment char after o/O
                                       " q   Format comments with gq
                                       " l   Do not break lines when they were longer than 'textwidth' to start with
set statusline=
let &statusline .= '%<%f'              " Filename, truncate right
let &statusline .= ' %h%m%r'           " [Help] [modified] [read-only]
let &statusline .= '%{len(getqflist()) > 0 ? "[QE]" : ""}'
let &statusline .= '%{len(getloclist(0)) > 0 ? "[LE]" : ""}'
let &statusline .= '%='                " Right-align from here on.
let &statusline .= ' %{get(v:completed_item, "abbr", "")}'
let &statusline .= ' [line %l of %L]'  " current line, total lines.
let &statusline .= ' [col %v]'         " column.
let &statusline .= ' [0x%B]'           " Byte value under cursor.

if $SSH_CLIENT . $SSH2_CLIENT . $SSH_CONNECTION is# ''
    set ttyfast                        " Assume the terminal is fast for smoother redrawing.
endif

if !has('nvim')    " nvim has different file formant. Only use it for testing so whatever.
    set viminfo='50,<0,n~/.cache/vim/viminfo " '50  save fewer marks.
                                           " <0   prevent saving registers.
endif

" Set/create directory to keep backup, swap, undo files.
set backupdir=$HOME/.cache/vim/backup | call mkdir(&backupdir, 'p', 0700)
set directory=$HOME/.cache/vim/swap   | call mkdir(&directory, 'p', 0700)
set viewdir=$HOME/.cache/vim/view     | call mkdir(&viewdir, 'p', 0700)
set undodir=$HOME/.cache/vim/undo     | call mkdir(&undodir, 'p', 0700)

" Highlight columns 80/120
fun! s:color()
    highlight SoftWrap cterm=underline gui=underline
    highlight HardWrap ctermbg=225 guibg=lightred
endfun
call s:color()
augroup softwrap
    au!
    au Colorscheme * call s:color()

    " I don't know why this needs to be in this autocmd, but sometimes it won't
    " work if it's not.
    au BufReadPost,BufNew *
        \  call matchadd('SoftWrap', '\%82v')
        \| call matchadd('HardWrap', '\%122v')
augroup end


" vim:expandtab
