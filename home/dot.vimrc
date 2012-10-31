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

if hostname =~ "xs1\.nl$"
	let env="work"
else
	let env="personal"
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

" Never beep
set visualbell

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
if env == "work"
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

""""""""""""
" Keybinds "
""""""""""""
map <F2> :registers<CR>
map <F3> :buffers<CR>
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

" Use standard color scheme (some Linuxes feel the need to overwrite this in
" global vimrc)
"colorscheme default
colorscheme peachpuff
set background=light

" 16 colors are enough
set t_Co=16

" Enable file type detection
filetype plugin indent on

" Don't highlight matching parens
"let loaded_matchparen=1

" Syntax breaks less often
autocmd BufEnter * :syntax sync fromstart

" Automatically close preview window when not needed anymore
"autocmd InsertLeave * call AutoClosePreviewWindow()
"autocmd CursorMovedI * call AutoClosePreviewWindow()
"function! AutoClosePreviewWindow()
"	if !&l:previewwindow
"		pclose
"	endif
"endfunction

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
"let python_highlight_numbers=1
"let python_highlight_builtins=1
"let python_highlight_exceptions=1
"let python_highlight_space_errors=1

""" PHP syntax settings
" highlighting parent error ] or )
let php_parent_error_close=1
let php_parent_error_open=1

""" Scheme syntax settings
let g:is_chicken=1

""""""""""""""""""
" Plugin options "
""""""""""""""""""
let mapleader=","

""" TODO: Check out this:
" http://vim.wikia.com/wiki/PHP_manual_in_Vim_help_format
