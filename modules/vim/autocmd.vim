" $dotid$

" Open new tabs by default
au VimEnter * if !&diff | tab all | tabfirst | endif

" Show a fortune on startup
au VimEnter * call Start()

" Settings for my job
au BufNewFile,BufRead /home/martin/code/* set expandtab ts=2 sts=2 sw=2

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
		\ :execute("normal `\"") |
	\ endif


" Syntax breaks less often, but it's a bit slower
au BufEnter * :syntax sync fromstart

" Set/unset some performance-related options if we're editing very large files
aug LargeFile
	let g:large_file = 10485760 " 10MB
	au BufReadPre *
		\ let f=expand("<afile>") |
		\ if getfsize(f) > g:large_file |
			\ set eventignore+=FileType |
			\ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
		\ else |
			\ set eventignore-=FileType |
		\ endif
aug END


""" Filetype-specific settings

" Run files with :make
au FileType python setlocal makeprg=python\ %
au FileType ruby setlocal makeprg=ruby\ %
au FileType javascript setlocal makeprg=node\ %
au FileType coffeescript setlocal makeprg=coffee\ -c\ %

" C files are almost always ts=8, and very often mix tabs & spaces
au FileType c setlocal ts=8 sts=8 sw=8

" *.html is almost always Twig or Jinja2; this will work fine with
" vanilla HTML as well
au FileType html setlocal filetype=htmldjango

" Set larger textwidth
au FileType html,htmldjango,eruby,haml setlocal textwidth=120

" Using tabs with Haskell doesn't seem to work well...
au FileType haskell setlocal expandtab ts=4 sts=4 sw=4

" Start PHP files with <?php
au BufNewFile *.php exe "normal O<?php" | exe "normal j"

" Set tabstop for Makefile, config files, etc.
au BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setlocal ts=8 sts=8 sw=8

" Fix 'temp file must be edited in place' on some platforms
au FileType crontab setlocal bkc=yes

" .md files are markdown
au BufRead,BufNewFile *.md,TODO setlocal filetype=markdown

" When using dwb ^E; assume markdown, and don't store in viminfo since these are
" temporary files
au BufRead,BufNewFile /home/martin/.cache/dwb/edit* setlocal ft=markdown viminfo=

" Don't break lines with links
au CursorMovedI *.md,*.markdown
	\ if getline(".") =~ '.*\[.*\](.*)' |
		\ setlocal textwidth=500 |
	\ else |
		\ setlocal textwidth=80 |
	\ endif

" indent/sass.vim overwrites this
au FileType sass setlocal sw=4 noexpandtab

" ftype/python.vim overwrites this
au FileType python setlocal ts=4 sts=4 sw=4 noexpandtab

" git syntax file is retarded, don't use it for commit messages
au BufNewFile,BufRead *.git/COMMIT_EDITMSG,*.git/MERGE_MSG,*.git/modules/*/COMMIT_EDITMSG setlocal filetype=

" Set textwidth to 76 for emails
au FileType email setlocal textwidth=76

" SSH authorized keys
au BufReadPost authorized_keys setlocal nowrap noautoindent nosmartindent textwidth=0 formatoptions=

" Read .odt files
au BufReadPost *.odt :%!odt2txt -

" Read/write *.gz files; from :help gzip-example
aug gzip
	au!
	au BufReadPre,FileReadPre *.gz setlocal bin
	au BufReadPost,FileReadPost *.gz '[,']!gunzip
	au BufReadPost,FileReadPost *.gz setlocal nobin
	au BufReadPost,FileReadPost *.gz execute ":doautocmd BufReadPost " . expand("%:r")
	au BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
	au BufWritePost,FileWritePost *.gz !gzip <afile>:r

	au FileAppendPre *.gz !gunzip <afile>
	au FileAppendPre *.gz !mv <afile>:r <afile>
	au FileAppendPost *.gz !mv <afile> <afile>:r
	au FileAppendPost *.gz !gzip <afile>:r
aug END


fun! MarkdownBlocks()
	fun! s:fill(line)
		" Remove all trailing whitespace
		let l:line = substitute(a:line, " *$", "", "")
		
		" Add trailing whitespace up to 'textwidth' length
		return l:line . repeat(' ', (&tw > 0 ? &tw : 80) - strdisplaywidth(l:line))
	endfun

	" Get all lines in a list
	let l:lines = getline(1, line('$'))

	" Map s:fill() to the lines that are a code block
	call map(l:lines, 'v:val[0] == "\t" || v:val[:3] == "    " ? s:fill(v:val) : v:val')

	" Reset the buffer to the lines
	call setline(1, l:lines)
endfun

" Remove all the trailing spaces
fun! MarkdownBlocksClean()
	let l:save_cursor = getpos(".")
	silent %s/^\(    \|\t\)\(.\{-}\)\( *\)$/\1\2/e
	call setpos('.', l:save_cursor)
endfun
au BufWritePre *.markdown call MarkdownBlocksClean()

" Set spaces on loading the file, leaving insert mode, and after writing it
au FileType markdown call MarkdownBlocks()
au InsertLeave *.markdown call MarkdownBlocks()
au BufWritePost *.markdown call MarkdownBlocks()


fun! CompleteSpace()
	" Save cursor position
	let l:save_cursor = getpos(".")

	" Get word we just completed ('borrowed' from: http://stackoverflow.com/a/14053922/660921)
	let l:word = matchstr(strpart(getline('.'), 0, col('.') - 1), '\k\+$')

	" Replace _ with space
	let l:new = substitute(l:word, "_", " ", "g")

	" Run :s
	exe "s/" . l:word . "/" . l:new . "/e"

	" Restore cursor
	call setpos(".", l:save_cursor)
endfun

if has("patch-7.3-598")
	au CompleteDone * call CompleteSpace()
endif
