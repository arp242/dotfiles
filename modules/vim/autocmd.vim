" $dotid: 96$

augroup basic
	autocmd!

	" Go to the last cursor location when a file is opened, unless this is a
	" git commit (in which case it's annoying)
	autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit'
			\| exe 'normal! g`"'
		\| endif

	" Syntax breaks less often, but it's a bit slower
	autocmd BufEnter * syntax sync fromstart

	" Never spellcheck urls
	autocmd BufReadPost * syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
augroup end


" Override settings that some filetypes change (grrr!)
augroup my_settings_not_your_settings_damnit
	autocmd!

	" Real men always use real tabs, and I like it four spaces wide.
	autocmd FileType * setlocal ts=4 sts=4 sw=4 noexpandtab

	" It sort of makes sense to set iskeyword for some filetypes, but I find it
	" confusing and prefer a consistent behaviour regardless of the filetype.
	autocmd FileType * setlocal iskeyword=@,48-57,_,192-255
augroup end


" Indentation preferences for various filetypes
augroup filetypes
	autocmd!

	" C files are almost always ts=8, and very often mix tabs & spaces
	" Help files need ts of 8
	autocmd FileType c,cpp,help setlocal ts=8 sts=8 sw=8

	" Set tabstop for Makefile, config files, etc.
	autocmd BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setlocal ts=8 sts=8 sw=8

	" Using tabs with Haskell doesn't seem to work well...
	autocmd FileType haskell setlocal expandtab
augroup end


" Settings for specific projects
augroup project_settings
	autocmd!

	" Tab settings for my job
	autocmd BufNewFile,BufRead /home/martin/code/TeamworkDesk/frontend/* setlocal expandtab ts=4 sts=4 sw=4
	autocmd BufNewFile,BufRead /home/martin/code/src/github.com/teamwork/TeamworkDesk/frontend/* setlocal expandtab ts=4 sts=4 sw=4
augroup end


" Various filetype-specific settings
augroup filetypes
	autocmd!

	" *.html is almost always Twig or Jinja2; this will work fine with
	" vanilla HTML as well
	autocmd FileType html setlocal filetype=htmldjango

	" Set larger textwidth for HTML
	autocmd FileType html,htmldjango,eruby,haml setlocal textwidth=120

	" Fix 'temp file must be edited in place' on some platforms
	autocmd FileType crontab setlocal backupcopy=yes

	" .md files and my TODO are markdown
	autocmd BufRead,BufNewFile *.md,TODO setlocal filetype=markdown

	" When using dwb/qutebrowser ^E; assume markdown, and don't store in viminfo
	" since these are temporary files
	autocmd BufRead,BufNewFile ~/.cache/dwb/edit*,qutebrowser-editor-*,~/.cache/itsalltext/*
		\ setlocal ft=markdown viminfo=

	" Highlight trailing spaces
	autocmd FileType markdown
		\  highlight MarkdownTrailingSpaces ctermbg=green guibg=green
		\| call matchadd('MarkdownTrailingSpaces', '\s\+$', 100)

	" git syntax file is retarded, don't use it for commit messages
	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG,*.git/MERGE_MSG,*.git/modules/*/COMMIT_EDITMSG
		\ setlocal filetype=

	" Set textwidth to 76 for emails
	autocmd FileType mail setlocal textwidth=76

	" These emails are usually DOS formatted (as should be, per RFC2822)
	autocmd BufReadPost *.eml setlocal fileformats+=dos fileformat=dos | edit

	" Make editing SSH authorized_keys & known_hosts less painful
	autocmd BufReadPost authorized_keys,known_hosts setlocal nowrap noautoindent nosmartindent textwidth=0 formatoptions=

	" Start PHP files with <?php
	autocmd BufNewFile *.php exe "normal O<?php" | exe "normal j"

	" PHP is shit and needs this
	autocmd FileType php nnoremap <buffer> <Leader>d iprint('<pre>' . htmlentities(print_r(X, True)) . '</pre>');<Esc>FXxi

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

let g:go_def_mapping_enabled = 0
fun! s:go()
	let g:go_highlight_trailing_whitespace_error = 0
	let g:go_fmt_command = "goimports"

	nmap gd <Plug>(go-def-tab)
    "nnoremap <buffer> <silent> gd :GoDef<cr>
    nnoremap <buffer> <silent> <C-]> :GoDef<cr>
    nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>
endfun

augroup ftype_go
	autocmd! 

	" Highlighting all trailing whitespace is annoying 
	autocmd Filetype go call s:go()
augroup end

fun! s:desk()
	call system('touch /home/martin/code/src/github.com/teamwork/desk/temp/restart.txt')
	"let l:out = system('nc sunbeam.teamwork.dev 9112')
	"if l:out != "Okay\n"
	"	echoerr l:out
	"endif
endfun

augroup restart_desk
	autocmd!
	autocmd BufWritePost /home/martin/code/src/github.com/teamwork/desk/*.go :call s:desk()
augroup end
