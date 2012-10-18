" vim:noexpandtab:ts=8:sts=8:sw=8
" $Config$
"

"""""""""""""
" Functions "
"""""""""""""
" Make directory if it doesn't exist yet
function! MkdirIfNeeded(dir, flags, permissions)
	if !isdirectory(a:dir)
		call mkdir(a:dir, a:flags, a:permissions)
	endif
endfunction

" Map key to toggle an option on/off
function! MapToggle(key, opt)
	let cmd=':set '.a:opt.'! \| set '.a:opt."?\<CR>"
	exec 'nnoremap '.a:key.' '.cmd
	exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Are we running on Windows or some UNIX system?
if has("win32") || has("win64")
	let uname='win32'
else
	let uname='unix'
endif

" System Hostname
let hostname=substitute(system('hostname'), '\n', '', '')

" Current username
if uname == "win32"
	let whoami=substitute(system("whoami /LOGONID"), '\n', '', '')
else
	let whoami=substitute(system("whoami"), '\n', '', '')
endif

""""""""""""""""""""
" Standard options "
""""""""""""""""""""
" Use Vim settings, rather then Vi settings
set nocompatible

" allow backspacing over everything
set backspace=indent,eol,start

" keep n lines of command line history
set history=500

" show the cursor position all the time
set ruler
" TODO: Tweak this
set rulerformat=%l,%c%V%=%P

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" highlight the last used search pattern.
set hlsearch

" Case-insensitive searching ...
set ignorecase

" ... Unless the patern contains upper case letters
set smartcase

" set 'text width' to 70 characters.
set textwidth=78

" Automatically write files on :q
set autowriteall

" Show a + when wrapping a line
set showbreak=+

" Wrap at word
set linebreak

" always set auto indenting on
set autoindent

" keep backup file
set backup

" Extension for backup files
set backupext=.bak

" String to use in 'list' mode
set listchars=tab:>-,trail:_

" Language for spell check
set spelllang=en_us

" Use English!
set helplang=en
set langmenu=en

" Use pop-up menu for right button
set mousemodel=popup_setpos

" Disable folds
set nofoldenable

" Always show tab line
set showtabline=2

" Always show statusline
set laststatus=2

" '500  - Remember 500 marks
" <500 - Save 500 lines for each register
" :500  - Remember 500 items in commandline history
" %     - Remeber buffer List 
set viminfo='500,:500,%,<500,s10

" Use UTF-8 by default
set encoding=utf-8

" Always use \n
set fileformat=unix

" Faster redrawing
set ttyfast

" Update term title
set title

" Restore it after leaving Vim
set titleold=

" Use blowfish for encrypting files
if has("cryptv")
	set cryptmethod=blowfish
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

" List all matches, only complete when it's unambigious
set wildmode=list,longest

" TODO ... ?
set completeopt=longest,menu,preview

" Allow cursor to go one character past the end of the line
set virtualedit=onemore

" TODO I need to look at this...
"set formatoptions+=

" The tab settings for work
if hostname =~ "LM-PC-03"
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set expandtab
" ... and for everything else
else
	set tabstop=2
	set shiftwidth=2
	set softtabstop=2
endif

" Use standard color scheme (some Linuxes feel the need to overwrite this in
" global vimrc)
colorscheme default
set background=light

" Set (& create if needed) a temp directory to keep backup & swap files
if uname == "win32"
	let tmpdir='C:/tmp/vim_' . whoami
else
	let tmpdir='/var/tmp/vim_' . whoami
endif
call MkdirIfNeeded(tmpdir, 'p', 0700)

" Where to keep backup files.
let &backupdir=tmpdir

" Keep swap file here
let &dir=tmpdir

" Go to the last cursor location when a file is opened
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Check syntax of PHP file
":autocmd FileType php noremap <C-Q> :!php -l %<CR>
set makeprg="php \ -l\ %"
set errorformat="%m\ in\ %f\ on\ line\ %l"
" TODO :compiler php does the same ...?

""""""""""""""""
" GUI settings "
""""""""""""""""
if has("gui_running")
	" Default width & height
	set lines=80
	set columns=150

	" Activate mouse
	set mouse=a

	" Default clipboard is system clipboard
	"set clipboard=unnamedplus
	set clipboard=unnamed

	" Also use the mouse for selection
	set selectmode=key,mouse

	" TODO I need to look at this ...
	"set guioptions+=

	" Set font
	set guifont=Dejavu_Sans_Mono:h10
endif

" Show error if line is longer than n chars
"match ErrorMsg '\%80v.\+'

""""""""""""
" Keybinds "
""""""""""""
"map <F2> :NERDTreeToggle<CR>
map <F2> :NERDTreeTabsToggle<CR>
map <F3> :TlistToggle<CR>
"map <F4> :IndentGuidesToggle<CR>
MapToggle <F10> list
MapToggle <F11> spell
MapToggle <F12> paste

inoremap <C-Space> <C-X><C-O>

" Replace array notation with object notation
"%s/\['\(.\{-}\)'\]/->\1/gc

"""""""""""""""""""""""
" Syntax highlighting "
"""""""""""""""""""""""
" Switch syntax highlighting on
syntax on

" Enable file type detection
filetype plugin indent on

" Don't highlight matching parens
"let loaded_matchparen=1

" Syntax breaks less often
autocmd BufEnter * :syntax sync fromstart

" Automatically close preview window when not needed anymore
autocmd InsertLeave * call AutoClosePreviewWindow()
autocmd CursorMovedI * call AutoClosePreviewWindow()

function! AutoClosePreviewWindow()
	if !&l:previewwindow
		pclose
	endif
endfunction

au BufNewFile,BufRead *[mM]akefile* setf make

" We want a tabstop of 8 (instead of 2) for some files (mainly configfiles)
au BufNewFile,BufRead
	\ Makefile*,
	\.vimrc,
	\crontab*,
	\*cshrc*,
	\*.conf,*.ini,*.cfg,*.rc,
	\ set ts=8 sts=8 sw=8

" GNU configure/autotools is a piece is shit. Loading the file with syntax is
" way to slow
au BufNewFile,BufRead
	\ configure,
	\ set syntax=

" html syntax
au BufNewFile,BufRead *.html,*.htm,*.inc set textwidth=120
au BufNewFile,BufRead *.tpl set textwidth=9999

""" Python syntax settings
let python_highlight_numbers=1
let python_highlight_builtins=1
let python_highlight_exceptions=1
let python_highlight_space_errors=1

""" PHP syntax settings
" SQL syntax highlighting inside strings
let php_sql_query=1

" HTML syntax highlighting inside strings
let php_htmlInStrings=1

" highlighting parent error ] or )
let php_parent_error_close=1
let php_parent_error_open =1

""" Scheme syntax settings
let g:is_chicken=1

""""""""""""""""""
" Plugin options "
""""""""""""""""""
let mapleader=","

""" NERD tree & NERD tree tabs
""" https://github.com/scrooloose/nerdtree
""" https://github.com/jistr/vim-nerdtree-tabs

" Set default width
let g:NERDTreeWinSize=40

" Remove 'Press ? for help'
let NERDTreeMinimalUI=1

" Open a NERDTree automatically when vim starts up without any files ...
autocmd vimenter * if !argc() | NERDTree | endif

" ... And don't open it otherwise
let g:nerdtree_tabs_open_on_gui_startup=0
let g:nerdtree_tabs_open_on_new_tab=0

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""" Taglist
""" http://www.vim.org/scripts/script.php?script_id=273
""" Setting it up with PHP:
""" http://lucasoman.blogspot.com/2010/09/vim-php-taglist-and-ctags.html
""" http://mwop.net/blog/134-exuberant-ctags-with-PHP-in-Vim
""" TODO: Perhaps replace it with Tagbar ... ? http://www.vim.org/scripts/script.php?script_id=3465

" Location of ctags on Windows
if uname == "win32"
	let Tlist_Ctags_Cmd=$VIM . '/vimfiles/win32-bin/ctags.exe'
	set tags=C:\ctags.txt
endif
"let Tlist_Ctags_Cmd='/usr/local/bin/exctags'

"ctags -R --exclude=.svn --tag-relative=yes --PHP-kinds=+cf-v --regex-PHP='/abstract\s+class\s+([^ ]+)/\1/c/' --regex-PHP='/interface\s+([^ ]+)/\1/c/' --regex-PHP='/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)function\s+\&?\s*([^ (]+)/\2/f/' lib/

" set the names of flags
let tlist_php_settings='php;c:class;f:function;d:constant'

" close all folds except for current file
let Tlist_File_Fold_Auto_Close=1

" make tlist pane active when opened
let Tlist_GainFocus_On_ToggleOpen=1

" width of window
let Tlist_WinWidth=40

" close tlist when a selection is made
let Tlist_Close_On_Select=1

""" Man Page Viewer
""" http://www.koch.ro/blog/index.php?/categories/14-VIM/P2.html
" Manpageview does't have an option to specify the links.exe location, so
" you'll need to add links to your path or put the links files in c:\windows\

" See: http://vim.wikia.com/wiki/View_PHP_documentation_for_current_word

" TODO: Doesn't seem to work ...

""" AutoComplPop
""" http://www.vim.org/scripts/script.php?script_id=1879
""" TODO: Doesn't work very well with PHP

""" TODO: Check out this:
" http://www.vim.org/scripts/script.php?script_id=159
" http://www.vim.org/scripts/script.php?script_id=42
" http://www.vim.org/scripts/script.php?script_id=1338
" http://vim.wikia.com/wiki/PHP_manual_in_Vim_help_format
" http://www.vim.org/scripts/script.php?script_id=1697
" http://www.vim.org/scripts/script.php?script_id=1984
" http://developers.blog.box.com/2007/06/20/how-to-debug-php-with-vim-and-xdebug-on-linux/
" http://www.vim.org/scripts/script.php?script_id=1798
