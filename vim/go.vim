" $dotid$

"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
"let g:go_list_type = "quickfix"

let g:go_fmt_experimental = 1

fun! s:setup()
	let g:go_highlight_trailing_whitespace_error = 0
	let g:go_highlight_fold_blocks = 0
	let g:go_fmt_command = "goimports"

	" Moar checkers!
	let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']

	" Open gd in a new tab
	let g:go_def_mapping_enabled = 0
	nmap gd <Plug>(go-def-tab)
	nnoremap <buffer> <silent> <C-]> :GoDef<cr>
	nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>

	" Fix christmas tree bullshit
	" https://github.com/fatih/vim-go/pull/1030
	highlight link goPredefinedIdentifiers goBoolean
endfun

fun! s:path(pkg)
	silent execute ':GoGuruScope ' . a:pkg
	silent execute ':GoPath /home/martin/code:/home/martin/code/src/' . a:pkg . '/vendor'
	"silent GoPath /home/martin/code:/home/martin/code/src/github.com/teamwork/TeamworkDesk/Godeps/_workspace
endfun

augroup my_go_settings
	autocmd!

	autocmd FileType go call s:setup()

	" GOPATH/GoGuru
	autocmd BufNewFile,BufRead ~/code/src/github.com/teamwork/TeamworkDesk/*.go
		\ call s:path("github.com/teamwork/TeamworkDesk")
	autocmd BufNewFile,BufRead ~/code/src/github.com/teamwork/desk/*.go
		\ call s:path("github.com/teamwork/desk")

	" Restart desk
	autocmd BufWritePost ~/code/src/github.com/teamwork/desk/*.go
		\ call system('echo "\04" | telnet sunbeam.teamwork.dev 9112')
	"\ call system('touch ~/code/src/github.com/teamwork/desk/temp/restart.txt')
augroup end
