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

	" Never spellcheck urls
	autocmd BufReadPost * syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
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

	" Set tabstop for Makefile, config files, etc.
	autocmd BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setlocal ts=8 sts=8 sw=8

	" Fix 'temp file must be edited in place' on some platforms
	autocmd FileType crontab setlocal backupcopy=yes

	" .md files are markdown
	autocmd BufRead,BufNewFile *.md,TODO setlocal filetype=markdown

	" When using dwb/qutebrowser ^E; assume markdown, and don't store in viminfo
	" since these are temporary files
	autocmd BufRead,BufNewFile ~/.cache/dwb/edit* setlocal ft=markdown viminfo=
	autocmd BufRead,BufNewFile qutebrowser-editor-* setlocal ft=markdown viminfo=
	autocmd BufRead,BufNewFile ~/.cache/itsalltext/* setlocal ft=markdown viminfo=

	" Highlight trailing spaces
	autocmd FileType markdown
		\  highlight MarkdownTrailingSpaces ctermbg=green guibg=green
		\| call matchadd('MarkdownTrailingSpaces', '\s\+$', 100)

	autocmd FileType markdown
		\ xnoremap <expr> ap XXX()

	" indent/sass.vim overwrites this
	autocmd FileType sass setlocal sw=4 noexpandtab

	" ftype/python.vim overwrites this
	autocmd FileType python setlocal ts=4 sts=4 sw=4 noexpandtab

	" It's annoying that this gets added
	autocmd FileType less setlocal iskeyword-=-

	" git syntax file is retarded, don't use it for commit messages
	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG,*.git/MERGE_MSG,*.git/modules/*/COMMIT_EDITMSG setlocal filetype=

	" Set textwidth to 76 for emails
	autocmd FileType mail setlocal textwidth=76

	" Make editing SSH authorized_keys & known_hosts less painful
	autocmd BufReadPost authorized_keys,known_hosts setlocal nowrap noautoindent nosmartindent textwidth=0 formatoptions=

	" Start PHP files with <?php
	autocmd BufNewFile *.php exe "normal O<?php" | exe "normal j"

	" PHP is shit and needs this
	autocmd FileType php nnoremap <buffer> <Leader>d iprint('<pre>' . htmlentities(print_r(X, True)) . '</pre>');<Esc>FXxi

	" These emails are usually DOS formatted (as should be, per RFC2822)
	autocmd BufReadPost *.eml setlocal fileformats+=dos fileformat=dos | edit

	" Varous MediaWiki things
	autocmd BufRead,BufNewFile *.mw,*.wiki setlocal filetype=mediawiki
	autocmd FileType mediawiki
		\  " Line breaks matter!
		\| setlocal linebreak textwidth=0 spell
		\| " No auto-wrap at all
		\| setlocal formatoptions-=t formatoptions-=c formatoptions-=a formatoptions+=l
		\| " Enable folding based on ==sections==
		\| setlocal foldexpr=getline(v:lnum)=~'^\\(=\\+\\)[^=]\\+\\1\\(\\s*<!--.*-->\\)\\=\\s*$'?\">\".(len(matchstr(getline(v:lnum),'^=\\+'))-1):\"=\"
		\| setlocal fdm=expr
augroup end


fun! s:dirvish() abort
	" U for up
	nnoremap <buffer> <silent> U :Dirvish %:h:h<CR>

	" I don't like this. I use q to close :reg, :ls, etc.
	silent! unmap <buffer> q

	" Add tab mappings
	nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
	xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>

	" Launch shell in cwd
	nnoremap <buffer> <C-t> :lcd %<CR>:silent exec '!' . (has('gui_running') ? 'xterm -e ' : '') . $SHELL<CR>:lcd<CR><C-l>

	" TODO: migrate patch back to vimrc
	nnoremap <nowait> <buffer> gw :call dirvish#toggle_filter('dirvish_wildignore', '/\v\.(png<Bar>jpg<Bar>jpeg<Bar>pyc)$/')<CR>
endfun
augroup dirvish_local
	autocmd!
	autocmd Filetype dirvish :call s:dirvish()
augroup end

fun! SelectCode() abort
	if getline('.')[0] != "\t"
		return 'ap'
	endif

	call search("[^\t]\n\t", 'b')
	

	"normal o
	"call search('^$')
	return ""
endfun
