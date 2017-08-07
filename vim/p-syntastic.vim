" Syntastic

let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
function! SyntasticCheckHook(errors)
	if !empty(a:errors)
		let g:syntastic_loc_list_height = min([len(a:errors), 10])
	endif
endfunction

" The default of -W2 is too verbose
let g:syntastic_ruby_mri_args = '-W1 -T1'

let g:syntastic_python_checkers = ['pep8', 'pylint']
"let g:syntastic_python_pep8_args = '--ignore=E501'
"let g:syntastic_python_flake8_args = '--ignore=E501'
"let g:syntastic_python_pylint_args = '-d wrong-import-position,missing-docstring,invalid-name,import-self'
let g:syntastic_python_pylint_args = '-j 4'

let g:syntastic_go_checkers = ['go', 'golint', 'govet']

let g:syntastic_markdown_checkers = ['proselint']

" Use the Bourne shell, and not tcsh
let g:syntastic_shell = "/bin/bash"

"let g:syntastic_mode_map = {'passive_filetypes': ['go', 'python']}
"let g:syntastic_mode_map = {'passive_filetypes': ['python']}

