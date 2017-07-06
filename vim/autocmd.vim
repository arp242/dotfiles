" $dotid$

augroup basic
	autocmd!

	" Go to the last cursor location when a file is opened, unless this is a git
	" commit (in which case it's annoying).
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'mygitcommit'
			\| exe 'normal! g`"'
		\| endif

	" Syntax breaks less often, but it's a bit slower
	autocmd BufEnter * syntax sync fromstart

	" Never spellcheck urls
	autocmd BufReadPost * syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
augroup end

" Indentation preferences for various filetypes
augroup my_filetypes
	autocmd!

	" Don't like the default one at all; it's far too opinionated on all sorts
	" of stupid stuff.
	autocmd FileType gitcommit 
		\  setlocal tw=80 filetype=mygitcommit
		\| syn match   gitcommitComment    "^#.*"

	" Reset some settings that these ftplugins or syntax files reset :-/
	autocmd FileType python setlocal ts=4
	autocmd FileType sass setlocal noexpandtab sw=4

	" 2 spaces is almost universal.
	autocmd FileType yaml setlocal expandtab ts=2 sts=2 sw=2

	" C files are almost always ts=8, and very often mix tabs & spaces
	autocmd FileType c,cpp setlocal ts=8

	" Set tabstop for Makefile, config files, etc.
	autocmd BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setlocal ts=8

	" Using tabs with Haskell doesn't seem to work well.
	autocmd FileType haskell setlocal expandtab

	" Set larger textwidth for HTML.
	autocmd FileType html,htmldjango,eruby,haml setlocal textwidth=120

	" Fix 'temp file must be edited in place' on some platforms.
	autocmd FileType crontab setlocal backupcopy=yes

	" My todo-file is in Markdown.
	autocmd BufRead,BufNewFile TODO setlocal filetype=markdown

	" Assume Markdown for dwb/qutebrowser ^E, and don't store in viminfo since
	" these are temporary files
	autocmd BufRead,BufNewFile ~/.cache/dwb/edit*,qutebrowser-editor-*,~/.cache/itsalltext/*
		\ setlocal ft=markdown viminfo=

	" Highlight trailing spaces in Markdown
	autocmd FileType markdown
		\  highlight MarkdownTrailingSpaces ctermbg=green guibg=green
		\| call matchadd('MarkdownTrailingSpaces', '\s\+$', 100)

	" Set textwidth to 76 for emails.
	autocmd FileType mail setlocal textwidth=76

	" These emails are usually DOS formatted (as should be, per RFC).
	autocmd BufReadPost *.eml setlocal fileformats+=dos fileformat=dos | edit

	" Make editing SSH authorized_keys & known_hosts less painful
	autocmd BufReadPost authorized_keys,known_hosts
		\ setlocal nowrap noautoindent nosmartindent textwidth=0 formatoptions=

	" Works better most of the time.
	autocmd FileType json,xml setlocal nowrap

	" Use a function for sanity!
	autocmd FileType mail call s:mail()
    autocmd FileType help call s:help()
augroup end

" Set up ft=mail
fun! s:mail()
	augroup ft_mail
		autocmd!
		" Increase textwidth for some headers; https://vi.stackexchange.com/a/9187/51
		autocmd CursorMoved,CursorMovedI *
			\  if index(["mailHeaderKey", "mailSubject", "mailHeaderEmail", "mailHeader"], synIDattr(synID(line('.'), col('.'), 1), 'name')) >= 0
			\|     setlocal textwidth=500
		    \| else
			\|     setlocal textwidth=72
			\| endif
	augroup end
endfun

" Show formatting characters in insert mode.
fun! s:help()
    augroup help_insert
        autocmd!
        autocmd InsertEnter <buffer> setlocal conceallevel=0 | highlight clear Ignore
        autocmd InsertLeave <buffer> setlocal conceallevel=2
    augroup end
endfun

" Remove Python 2 keywords.
augroup angering_zed_shaw
	autocmd!
	autocmd Syntax python
		\ syn keyword pythonTwoBuiltin basestring cmp execfile file long
		\                              raw_input reduce reload unichr unicode
		\                              xrange apply buffer coerce intern
augroup end
