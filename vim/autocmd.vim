augroup basic
	au!

	" Go to the last cursor location when a file is opened, unless this is a git
	" commit (in which case it's annoying).
	au BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit'
			\| exe 'normal! g`"'
		\| endif

	" Never spellcheck urls.
	au BufReadPost * syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
augroup end

" Preferences for various filetypes.
augroup my_filetypes
	au!

	" Don't need the syntax highlighting for git commits; don't like it at all.
	au FileType gitcommit
		\  setl syntax=OFF
		\| syn match gitcommitComment "^#.*"
		\| setl ts=8

	" Reset some settings that these ftplugins or syntax files reset :-/
	au FileType python setl ts=4
	au FileType sass setl noexpandtab sw=4

	" Remove Python 2 keywords.
	au Syntax python
		\ syn keyword pythonTwoBuiltin basestring cmp execfile file long unichr
		\     raw_input reduce reload unicode xrange apply buffer coerce intern

	" 2 spaces is almost universal.
	au FileType yaml setl expandtab ts=2 sts=2 sw=2

	" C files are almost always ts=8, and very often mix tabs & spaces.
	au FileType c,cpp setl ts=8

	" Set tabstop for Makefile, config files, etc.
	au BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setl ts=8

	" Set larger textwidth for HTML.
	au FileType html,htmldjango,eruby,haml setl textwidth=120

	" Fix 'temp file must be edited in place' on some platforms.
	au FileType crontab setl backupcopy=yes

	" My todo-file is in Markdown.
	au BufRead,BufNewFile TODO setl filetype=markdown

	" Highlight trailing spaces in Markdown
	au FileType markdown
		\  highlight MarkdownTrailingSpaces ctermbg=green guibg=green
		\| call matchadd('MarkdownTrailingSpaces', '\s\+$', 100)

	" Set textwidth to 76 for emails.
	au BufReadPost /tmp/mail-* setl ft=mail | normal! 0Go
	au FileType mail setl textwidth=76

	" These emails are usually DOS formatted (as should be, per RFC).
	au BufReadPost *.eml setl fileformats+=dos fileformat=dos | edit!

	" Make editing SSH authorized_keys and known_hosts less painful.
	au BufReadPost authorized_keys,known_hosts
		\ setl nowrap noautoindent nosmartindent textwidth=0 formatoptions=

	" Works better most of the time.
	au FileType json,xml setl nowrap

	" Show formatting characters only in insert mode.
	au FileType help
				\  silent! packadd! vim-vimhelplint
				\| if &modifiable | setl colorcolumn=78 | endif
				\| augroup help_insert
				\|     au InsertEnter <buffer> setl conceallevel=0 | highlight clear Ignore
				\|     au InsertLeave <buffer> setl conceallevel=2
				\| augroup end
augroup end

" is# and isnot# won't work otherwise. Emailed syntax maintainer on 20190309.
augroup fix_vimscript
	au!
	au FileType vim syn match vimOper
				\ "\(==\|!=\|>=\|<=\|=\~\|!\~\|>\|<\|=\|isnot\|is\)[?#]\{0,2}"
				\ skipwhite nextgroup=vimString,vimSpecFile
augroup end
