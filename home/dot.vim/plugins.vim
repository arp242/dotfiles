""" ShowMarks
" Off by default
let g:showmarks_enable=0


""" CtrlP
let g:ctrlp_map = "<Leader>t"
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:100'

" Open files in a tab
let g:ctrlp_open_new_file = 't'

" At my previous job, the project had lots 'o files and was on a fairly slow
" network drive...
"let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_cache_dir = tmpdir

" ...but not anymore! We don't need caching anymore...
let g:ctrlp_use_caching = 0

if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


""" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
