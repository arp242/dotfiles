" vim:noexpandtab:ts=8:sts=8:sw=8
" $hgid:

"""""""""""""""""
""" Functions """
"""""""""""""""""
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


""""""""""""""""""""""""
""" Standard options """
""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings
set nocompatible

" Allow backspacing over everything
set backspace=indent,eol,start

" Keep n lines of command line history
set history=500

" Show the cursor position all the time
set ruler

" %40 - 40 wide
" %= Right align
" %l line num of cursor
" %L Total lines in buf
" %c column of cursor
" %o Byte pos of cursor
" %B Byte value under cursor
set rulerformat=%40(%=[%l/%L]\ [%c\ %o\ 0x%B]%)

" Display incomplete commands in status line
set showcmd

" Jump to search word while typing
set incsearch

" Highlight the last used search pattern.
set hlsearch

" Case-insensitive searching ...
set ignorecase

" ... Unless the patern contains upper case letters
set smartcase

" set 'text width' to 80 characters.
set textwidth=80

" Show a + when wrapping a line
set showbreak=+

" Wrap at word
set linebreak

" Always set auto indenting on
set autoindent

" Keep backup file when writing
set backup

" Extension for backup files
set backupext=.bak

" String to use in 'list' mode
set listchars=tab:>-,trail:_

" Default language for spell check
set spelllang=en_us

" Always use English in UI/help
set helplang=en
set langmenu=en

" Use pop-up menu for right button
set mousemodel=popup_setpos

" Disable folds
set nofoldenable

" Always show tab bar at top
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

" .Restore old title after leaving Vim
set titleold=

" Never beep
set visualbell

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

" Ignore these files in completion
set wildignore=*.o,*.pyc

" List all matches, only complete when it's unambigious
set wildmode=list:longest,full

" Insert mode completion
set completeopt=longest,menu

" Allow cursor to go one character past the end of the line
set virtualedit=onemore

" TODO I need to look at this...
"set formatoptions+=

set tabstop=4
set shiftwidth=4
set softtabstop=4

" Round indent to multiple of shiftwidth when using < and >
set shiftround

" The tab settings for work
if env == "work"
	set expandtab
endif

" Set (& create if needed) a temp directory to keep backup & swap files
if uname == "win32"
	let tmpdir='C:/tmp/vim_' . whoami
else
	let tmpdir='/var/tmp/vim_' . whoami
endif
call MkdirIfNeeded(tmpdir, 'p', 0700)

let &backupdir=tmpdir
let &dir=tmpdir

" Switch syntax highlighting on
syntax on

" Use standard color scheme (some Linuxes feel the need to overwrite this in
" global vimrc)
colorscheme default
set background=light

" 16 colors are enough
set t_Co=16

" Enable file type detection
filetype plugin indent on

" Go to the last cursor location when a file is opened
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Syntax breaks less often
autocmd BufEnter * :syntax sync fromstart


""""""""""""""""""""
""" GUI settings """
""""""""""""""""""""
if has("gui_running")
	" Default width & height
	set lines=80
	set columns=80

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


""""""""""""""""
""" Keybinds """
""""""""""""""""
nnoremap <F2> :registers<CR>
nnoremap <F3> :buffers<CR>
nnoremap <F4> :jumps<CR>
nnoremap <F5> :TlistToggle<CR>
nnoremap <F6> :marks<CR>

MapToggle <F10> list
MapToggle <F11> spell
MapToggle <F12> paste

map ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>


""""""""""""""""""""""""""""""""""
""" Language-specific settings """
""""""""""""""""""""""""""""""""""

""" HTML
au BufNewFile,BufRead *.html,*.htm,*.inc,*.tpl set textwidth=120

""" Haskell
" Tabs don't work well with haskell
au BufNewFile,BufRead *.hs set expandtab ts=4 sts=4 sw=4

""" Scheme
let g:is_chicken=1

""" Python
" https://github.com/davidhalter/jedi-vim

""" PHP
" http://www.vim.org/scripts/script.php?script_id=3171

" Replace array notation with object notation in PHP
"map <F4> :s/\['\(.\{-}\)'\]/->\1/gc<CR>
"imap <F4> :s/\['\(.\{-}\)'\]/->\1/gc<CR>


" highlighting parent error ] or )
let php_parent_error_close=1
let php_parent_error_open=1

""" Misc.
" We want a tabstop of 8 (instead of 2)
au BufNewFile,BufRead
	\ [Mm]akefile*,
	\.vimrc,
	\crontab*,
	\*cshrc*,
	\*.conf,*.ini,*.cfg,*.rc,
	\ set ts=8 sts=8 sw=8

" Loading GNU configure crap with syntax is way too slow.
au BufNewFile,BufRead configure set syntax=

""""""""""""""""""""""
""" Plugin options """
""""""""""""""""""""""
""" SuperTab
" Default is <C-p>
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
"let g:SuperTabDefaultCompletionType = "context"
"

""" Taglist
" Exit Vim when only the  taglist window is present
let Tlist_Exit_OnlyWindow = 1

" Display the tags for only the current active buffer
"let Tlist_Show_One_File = 1

let Tlist_WinWidth=40

""" ShowMarks
" Off by default
let g:showmarks_enable=0


" (Possibly) check this out:
" http://www.vim.org/scripts/script.php?script_id=2507
" http://www.vim.org/scripts/script.php?script_id=1234
" https://github.com/xolox/vim-easytags#readme 
" https://github.com/shawncplus/phpcomplete.vim
" http://www.mwop.net/blog/134-exuberant-ctags-with-PHP-in-Vim.html
" http://www.vim.org/scripts/script.php?script_id=610
" http://andrew-stewart.ca/2012/10/31/vim-ctags
" http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
" https://bacardi55.org/2013/02/27/how-can-i-use-vim-on-a-daily-basis.html#/
