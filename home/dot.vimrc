" vim:noexpandtab:ts=8:sts=8:sw=8
" $hgid:

"""""""""""""""""
""" Functions """
"""""""""""""""""
" Make directory if it doesn't exist yet
fun! MkdirIfNeeded(dir, flags, permissions)
	if !isdirectory(a:dir)
		call mkdir(a:dir, a:flags, a:permissions)
	endif
endfun

" Map key to toggle an option on/off
fun! MapToggle(key, opt)
	let cmd=':set '.a:opt.'! \| set '.a:opt."?\<CR>"
	exec 'nnoremap '.a:key.' '.cmd
	exec 'inoremap '.a:key." \<C-O>".cmd
endfun
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Replace `} else {' with `}<CR>else {'
fun! SaneIndent()
	"silent %s/\(\s*\)}\s*\(else\|catch\)/\1}\r\1\2/g
	silent! %s/\v(\s*)}\s*(else|catch)/\1}\r\1\2/g
	execute "normal ''"
endfun

" Replace `}<CR>else {' with `} else {'
fun! NotSoSaneIndent()
	"silent %s/}\_.\(\s*\)\(else\|catch\)/} \2/g
	silent! %s/\v}\_.(\s*)(else|catch)/} \2/g
	execute "normal ''"
endfun

" Are we running on Windows or some UNIX system?
if has("win32") || has("win64")
	let uname='win32'
else
	let uname='unix'
endif

" System Hostname
let hostname = substitute(system('hostname'), '\n', '', '')

" Current username
if uname == "win32"
	let whoami = substitute(system("whoami /LOGONID"), '\n', '', '')
else
	let whoami = substitute(system("whoami"), '\n', '', '')
endif

try
	let env = env
catch /E121/
	if hostname =~ "martin-xps"
		let env = "work"
	else
		let env = "personal"
	endif
endtry


execute pathogen#infect()

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
set fileformats=unix

" Faster redrawing
set ttyfast

" Update term title
set title

" .Restore old title after leaving Vim
set titleold=

" Never beep
"set visualbell

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
set wildignore=*.o,*.pyc,*.png,*.jpg

" List all matches, only complete when it's unambigious
set wildmode=list:longest,full

" Insert mode completion
set completeopt=longest,menu

" Allow cursor to go one character past the end of the line
set virtualedit=onemore

" Max. number of tabs to be open with -p argument or :tab all"
set tabpagemax=50

" TODO I need to look at this...
"set formatoptions+=

set tabstop=4
set shiftwidth=4
set softtabstop=4

" Round indent to multiple of shiftwidth when using < and >
set shiftround

" Backspace at start of line remove shiftwidith worth of space
set smarttab

" The tab settings for work
if env == "work"
	set expandtab
	set ts=2
	set sw=2
	set sts=2
	set fileformats=unix,dos
endif

" Set (& create if needed) a temp directory to keep backup & swap files
if uname == "win32"
	let tmpdir = 'C:/tmp/vim_' . whoami
else
	let tmpdir = '/var/tmp/vim_' . whoami
endif
call MkdirIfNeeded(tmpdir, 'p', 0700)

let &backupdir = tmpdir
let &dir = tmpdir

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
au BufEnter * :syntax sync fromstart


""""""""""""""""""""
""" GUI settings """
""""""""""""""""""""
if has("gui_running")
	" Default width & height
	set lines=55
	set columns=120

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
"nnoremap <F3> :buffers<CR>
nnoremap <F3> :BufExplorer<CR>
nnoremap <F4> :jumps<CR>
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <F6> :marks<CR>
nnoremap <F8> :YRShow<CR>

MapToggle <F10> list
MapToggle <F11> spell
MapToggle <F12> paste

map ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-L> to clear the highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" We don't need no stinkin' ex mode
map Q gq

" Typo's
"cmap W w
"cmap Q q
"cmap Wq wq
"cmap WQ wq

""""""""""""""""""""""""""""""""""
""" Language-specific settings """
""""""""""""""""""""""""""""""""""

""" HTML
au BufNewFile,BufRead *.html,*.htm,*.inc,*.tpl set textwidth=120

""" Haskell
" Tabs don't work well with haskell
au BufNewFile,BufRead *.hs set expandtab ts=4 sts=4 sw=4

" PHP
au BufNewFile *.php exe "normal O<?php"

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

" HTML is almost always Twig or Jinja
au BufNewFile,BufRead *.html set syntax=htmldjango


""""""""""""""""""""""
""" Plugin options """
""""""""""""""""""""""
""" ShowMarks
" Off by default
let g:showmarks_enable=0

""" CtrlP
let g:ctrlp_map = "<Leader>t"
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:100'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = tmpdir
let g:ctrlp_open_new_file = 't'
"let g:ctrlp_user_command =  'find %s -type f'

let g:syntastic_auto_loc_list = 1

fun! LastCommand()
	let l:i = -1

	while l:i > -100
		let l:cmd = histget("cmd", l:i)
		if strpart(l:cmd, 0, 1) == "!"
			let l:i = 1
			execute l:cmd
			break
		endif
		let l:i -= 1
	endwhile

	if l:i < 1
		echoerr "No command found"
	endif
endfun

nnoremap <Leader>r :call LastCommand()<CR>
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P
