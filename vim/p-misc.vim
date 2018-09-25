" vim-lookup
augroup p_misc
	autocmd!
	autocmd FileType vim nnoremap <buffer> <silent> gd :call lookup#lookup()<cr>
augroup end

" vim-makejob
" Hide the preview window during execution.
let g:makejob_hide_preview_window = 1

" completor.vim
let g:completor_auto_trigger = 0
let g:completor_def_split = 'tab'
let g:completor_doc_position = 'top'
let g:completor_auto_close_doc = 0
let g:completor_min_chars = 0

augroup my_go
	autocmd!

	" TODO: don't put cursor here.
	" TODO: make smaller
	autocmd Filetype go nnoremap <buffer> K  :call completor#do('doc')<CR>

	" TODO: can't open in tab
	" TODO: use path relative to cwd
	" TODO: re-use buffers
	autocmd Filetype go nnoremap <buffer> gd :call completor#do('definition')<CR>
augroup end

"set completeopt=longest,menuone
"*g:completor_complete_options*
" Defaut: menuone,noselect,preview

" TODO: add command/function for this; don't like the formatting in stl.
" :echo matchup#delim#get_current('all', 'both_all'):
"let g:matchup_matchparen_status_offscreen = 0
"let g:matchup_matchparen_deferred = 1
