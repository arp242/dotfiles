" $dotid$

let g:go_fmt_experimental = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_fold_blocks = 0
let g:go_fmt_command = "goimports"

"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_jump_to_error = 0
let g:go_gocode_unimported_packages = 1
"let g:go_template_use_pkg = 0

fun! s:setup()
	" Open gd in a new tab
	" TODO: Path is fubar
	nmap gd <Plug>(go-def-tab)
	nnoremap <buffer> <silent> <C-]> :GoDef<cr>
	nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<cr>
endfun

augroup my_go_settings
	autocmd!

	autocmd FileType go call s:setup()

	" Restart desk
	autocmd BufWritePost ~/code/src/github.com/teamwork/desk/*.go
		\ call system('echo "\04" | telnet sunbeam.teamwork.dev 9112')
augroup end
