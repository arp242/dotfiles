" Settings for Vim-go

augroup my_go_settings
	autocmd!

	" Shortcuts for make/test/run.
	autocmd FileType go nnoremap <buffer> MM :wa<CR>:compiler go<CR>:LmakeJob<CR>
	autocmd FileType go nnoremap <buffer> TT :wa<CR>:compiler gotest<CR>:LmakeJob<CR>
	autocmd FileType go nnoremap <buffer> RR :wa<CR>:compiler gorun<CR>:LmakeJob<CR>

	autocmd FileType go nnoremap <buffer> <Leader>a :call <SID>alt()<CR>

	" Set compiler.
	"autocmd FileType go
	"	\  if expand('%')[-8:] is# '_test.go'
	"	\|   compiler gotest
	"	\|   let &l:makeprg = 'go test -tags="testdb testhub"'
	"	\|  else
	"	\|   compiler go
	"	\|   let &l:makeprg = 'go install -tags="testdb testhub"'
	"	\|   let s:d = './cmd/' . fnamemodify(system('go list .')[:-2], ':t')
	"	\|   if isdirectory(s:d)
	"	\|     let &l:makeprg .= ' ' . s:d
	"	\| endif
augroup end

fun! s:alt()
	let l:file = expand('%')
	if empty(l:file)
		return
	elseif l:file[-8:] is# '_test.go'
		let l:alt_file = l:file[:-9] . '.go'
	elseif l:file[-3:] is# '.go'
		let l:alt_file = l:file[:-4] . '_test.go'
	else
		return
	endif

	let l:cmd = 'tabe'
	if bufloaded(l:alt_file)
		let l:cmd = 'sbuffer'
	endif
	exe printf(':%s %s', l:cmd, fnameescape(l:alt_file))
endfun
