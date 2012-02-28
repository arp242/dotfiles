"
" Standard options
"
set nofoldenable
set nocompatible	" Use Vim settings, rather then Vi settings
set backspace=indent,eol,start	" allow backspacing over everything
set history=100		" keep 100 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch		" highlight the last used search pattern.
set textwidth=78	" set 'text width' to 78 characters.
set autoindent		" always set auto indenting on
set autowriteall	" Automatically write files
set ignorecase		" Case-insensitive searching
set smartcase		" Case-sensitive searching only if pattern has caps
set sbr=+		" Show a + when wrapping a line
set lbr			" Wrap at word
set tabstop=2		" Tabs are 2 spaces wide
set shiftwidth=2	" Auto-indent 2 spaces wide
set softtabstop=2	" Still 2...
set backup		" keep backup file
set backupext=.bak	" Extension for backup files
set backupdir=/var/tmp/carpet	" Where to keep backup files.
set dir=/var/tmp/carpet	" Keep swap file here
set listchars=tab:>-,trail:_	" String to use in 'list' mode
set spelllang=en_us	" Default language for spell check
set mousemodel=popup_setpos	" Use pop-up menu for right button
set mouse=		" Disable mouse by default
set virtualedit=onemore	" Allow cursor to move one char beyond end of line
set showtabline=2	" Always show tab line
set foldmethod=marker	" Automatically fold stuff
set foldopen=hor,mark,search,block,tag,undo	" Automatically unfold on these events
set foldclose=all	" Automatically close folds when moving out of them
set laststatus=2	" Always show statusline
set viminfo='500,<500,s10	" Increase viminfo size
set encoding=utf-8	" Default encoding

" Map key to toggle an option
function MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <F10> list
MapToggle <F11> spell
MapToggle <F12> paste

nmap . .`[

syntax on		" Switch syntax highlighting on
filetype plugin indent on	" Enable file type detection.
"autocmd BufEnter * :syntax sync fromstart	" Syntax breaks less often

au BufNewFile,BufRead *[mM]akefile* setf make

" We want a tabstop of 8 (instead of 2) for some files (mainly configfiles)
au BufNewFile,BufRead
	\ Makefile*,
	\.vimrc,
	\crontab*,
	\*cshrc*,
	\*.conf,*.cfg,*.rc,
	\ set ts=8 sts=8 sw=8

" html syntax: Increate width
au BufNewFile,BufRead *.html,*.htm,*.inc set textwidth=100

let python_highlight_numbers = 1
let python_highlight_builtins = 1
let python_highlight_exceptions = 1
let python_highlight_space_errors = 1

let php_sql_query=1		" SQL syntax highlighting inside strings
let php_htmlInStrings=1		" HTML syntax highlighting inside strings
let php_parent_error_close=1	" highlighting parent error ] or )
let php_parent_error_open=1
"let php_folding=1		" for folding classes and functions

" When editing a file, try to jump to the last known cursor position.
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\ exe "normal g`\"" |
	\ endif

" Disable syntax highlighting for (very) large files
au BufReadPost *
	\ if getfsize(bufname("%")) > 512*1024 | 
		\ set syntax= |
	\ endif
