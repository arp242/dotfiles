" $dotid$

" Use the undo file
set undofile

" When loading a file, store the curent undo sequence
augroup undo
	autocmd!
	autocmd BufReadPost,BufCreate,BufNewFile * let b:undo_saved = undotree()['seq_cur'] | let b:undo_warned = 0
augroup end

fun! Undo()
	" Don't do anything if we can't modify the buffer or there's no filename
	if !&l:modifiable || expand('%') == '' | return | endif

	" Warn if the current undo sequence is lower (older) than whatever it was
	" when openingthe file
	if !b:undo_warned && undotree()['seq_cur'] <= b:undo_saved
		let b:undo_warned = 1
		echohl ErrorMsg | echo 'WARNING! Using undofile!' | echohl None
		sleep 1
	endif
endfun
noremap u :call Undo()<Cr>u

fun! Redo()
	" Reset the warning flag
	if &l:modifiable && b:undo_warned && undotree()['seq_cur'] >= b:undo_saved
		let b:undo_warned = 0
	endif
endfun
nnoremap <C-r> :call Redo()<Cr><C-r>
