" $dotid$

" Trick from: http://vi.stackexchange.com/a/2150/51

" Manually write to the undo file on exit
fun! WriteUndo()
	let undofile = escape(undofile(expand('%')),'%')
	exe "wundo " . undofile
endfun


" Manually read the undo file
fun! ReadUndo()
	let undofile = undofile(expand('%'))
	if filereadable(undofile)
		let undofile = escape(undofile,'%')
		exe "rundo " . undofile
	endif
endfun


if has('persistent_undo')
	nnoremap <leader>u :call ReadUndo()<CR>
	au BufWritePost * call WriteUndo()
endif
