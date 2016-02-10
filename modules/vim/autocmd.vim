" $dotid$

augroup basic
	autocmd!

	" Tab settings for my job
	"autocmd BufNewFile,BufRead /home/martin/code/* set expandtab ts=2 sts=2 sw=2

	" Go to the last cursor location when a file is opened, unless this is a
	" git commit (in which case it's annoying)
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") && &filetype != "gitcommit" |
			\ :execute("normal `\"") |
		\ endif

	" Syntax breaks less often, but it's a bit slower
	autocmd BufEnter * :syntax sync fromstart
augroup end


" Filetype-specific settings
augroup filetypes
	autocmd!

	" C files are almost always ts=8, and very often mix tabs & spaces
	autocmd FileType c,cpp setlocal ts=8 sts=8 sw=8

	" *.html is almost always Twig or Jinja2; this will work fine with
	" vanilla HTML as well
	autocmd FileType html setlocal filetype=htmldjango

	" Set larger textwidth for HTML
	autocmd FileType html,htmldjango,eruby,haml setlocal textwidth=120

	" Using tabs with Haskell doesn't seem to work well...
	autocmd FileType haskell setlocal expandtab ts=4 sts=4 sw=4

	" Start PHP files with <?php
	autocmd BufNewFile *.php exe "normal O<?php" | exe "normal j"

	" Set tabstop for Makefile, config files, etc.
	autocmd BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setlocal ts=8 sts=8 sw=8

	" Fix 'temp file must be edited in place' on some platforms
	autocmd FileType crontab setlocal bkc=yes

	" .md files are markdown
	autocmd BufRead,BufNewFile *.md,TODO setlocal filetype=markdown

	" When using dwb/qutebrowser ^E; assume markdown, and don't store in viminfo
	" since these are temporary files
	autocmd BufRead,BufNewFile /home/martin/.cache/dwb/edit* setlocal ft=markdown viminfo=
	autocmd BufRead,BufNewFile qutebrowser-editor-* setlocal ft=markdown viminfo=

	" indent/sass.vim overwrites this
	autocmd FileType sass setlocal sw=4 noexpandtab

	" ftype/python.vim overwrites this
	autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab

	" It's annoying that this gets added
	autocmd FileType less setlocal iskeyword-=-

	" git syntax file is retarded, don't use it for commit messages
	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG,*.git/MERGE_MSG,*.git/modules/*/COMMIT_EDITMSG setlocal filetype=

	" Set textwidth to 76 for emails
	autocmd FileType email setlocal textwidth=76

	" Make editing SSH authorized_keys & known_hosts less painful
	autocmd BufReadPost authorized_keys,known_hosts setlocal nowrap noautoindent nosmartindent textwidth=0 formatoptions=

	" These emails are usually DOS formatted (as should be, per RFC2822)
	autocmd BufReadPost *.eml setlocal fileformats+=dos fileformat=dos | edit

	autocmd BufReadPost * syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
augroup end
