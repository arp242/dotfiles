" $dotid$

" Make paths in the Dirvish buffer relative to getcwd().
let g:dirvish_relative_paths = 1

fun! s:dirvish() abort
	" I don't like this. I use q to close :reg, :ls, etc.
	silent! unmap <buffer> q

	" Add tab mappings
	nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
	xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>

	" Launch shell in cwd
	nnoremap <buffer> <C-t> :lcd %<CR>:silent exec '!' . (has('gui_running') ? 'xterm -e ' : '') . $SHELL<CR>:lcd<CR><C-l>
endfun

augroup dirvish_local
	autocmd!
	autocmd Filetype dirvish :call s:dirvish()
augroup end
