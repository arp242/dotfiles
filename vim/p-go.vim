" $dotid$

let g:go_fmt_experimental = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_fold_blocks = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 0

let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_jump_to_error = 0
let g:go_gocode_unimported_packages = 1

augroup my_go_settings
	autocmd!

	" Open gd in a new tab with gd
	autocmd FileType go nmap gd <Plug>(go-def-tab)
	" Need to map these defaults because go_def_mapping_enabled is off.
	autocmd FileType go
		\ nnoremap <buffer> <silent> <C-]> :GoDef<CR>
		\| nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<CR>

	" Make sure the correct GOPATH is used; vim-go doesn't deal with two GOPATHs
	" very well.
	autocmd BufRead /home/martin/work/*.go :silent :GoPath /home/martin/work

	" Restart desk
	autocmd BufWritePost ~/work/src/github.com/teamwork/desk/*.go
		\ call system('echo "\04" | telnet sunbeam.teamwork.dev 9112')
augroup end
