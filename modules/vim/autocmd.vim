" $logid$
"
" open new tabs by default
" http://vi.stackexchange.com/questions/310/how-do-i-make-opening-new-tabs-the-default
" TODO: You now focus the *last* tab, and not the first, as if with -p
" TODO: Shows last edit on `vi` without file
"au VimEnter * set tabpagemax=9999|sil tab ball|set tabpagemax&vim

" Show a fortune on startup
autocmd VimEnter * call Start()

" Go to the last cursor location when a file is opened, unless this is a
" git commit (in which case it's annoying)
au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
		\ :execute("normal `\"") |
	\ endif

" Syntax breaks less often, but it's a bit slower
au BufEnter * :syntax sync fromstart


" Set/unset some performance-related options if we're editing very large files
augroup LargeFile
	let g:large_file = 10485760 " 10MB
	au BufReadPre *
		\ let f=expand("<afile>") |
		\ if getfsize(f) > g:large_file |
			\ set eventignore+=FileType |
			\ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
		\ else |
			\ set eventignore-=FileType |
		\ endif
augroup END

""" Languages/filetypes

" Run files with :make
au FileType python set makeprg=python\ %
au FileType ruby set makeprg=ruby\ %
au FileType javascript set makeprg=node\ %
au FileType coffeescript set makeprg=coffee\ -c\ %

" *.html is almost always Twig or Jinja2; this will work fine with
" vanilla HTML as well
au FileType html set filetype=htmldjango

" Set larger textwidth
au FileType html,htmldjango,eruby,haml setlocal textwidth=120

" Using tabs with Haskell doesn't seem to work well...
au FileType haskell setlocal expandtab ts=4 sts=4 sw=4

" Start PHP files with <?php
au BufNewFile *.php exe "normal O<?php"

" Set tabstop for Makefile, config files, etc.
au BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc set ts=8 sts=8 sw=8

" .md files are markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Don't break lines with links
au CursorMovedI *.md,*.markdown
	\ if getline(".") =~ '.*\[.*\](.*)' |
		\ set textwidth=500 |
	\ else |
		\ set textwidth=80 |
	\ endif

" indent/sass.vim overwrites this
au FileType sass setlocal sw=4 noexpandtab

" ftype/python.vim overwrites this
au FileType python setlocal ts=4 sts=4 sw=4 noexpandtab

" git syntax file is retarded, don't use it for commit messages
au BufNewFile,BufRead *.git/COMMIT_EDITMSG set filetype=
au BufNewFile,BufRead *.git/MERGE_MSG set filetype=
au BufNewFile,BufRead *.git/modules/*/COMMIT_EDITMSG set filetype=

" Read .odt files
autocmd BufReadPost *.odt :%!odt2txt -

" Read/write *.gz files; from :help gzip-example
augroup gzip
	autocmd!
	autocmd BufReadPre,FileReadPre *.gz set bin
	autocmd BufReadPost,FileReadPost *.gz '[,']!gunzip
	autocmd BufReadPost,FileReadPost *.gz set nobin
	autocmd BufReadPost,FileReadPost *.gz execute ":doautocmd BufReadPost " . expand("%:r")
	autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
	autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r

	autocmd FileAppendPre *.gz !gunzip <afile>
	autocmd FileAppendPre *.gz !mv <afile>:r <afile>
	autocmd FileAppendPost *.gz !mv <afile> <afile>:r
	autocmd FileAppendPost *.gz !gzip <afile>:r
augroup END

" Set textwidth to 76 for emails
au FileType email set textwidth=76
