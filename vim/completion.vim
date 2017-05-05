" $dotid$

" TODO: It looks like I'm reinventing the wheel
" http://www.vim.org/scripts/script.php?script_id=5184
fun! GuessType()
	" Use omnicomplete for Go
	if &filetype == 'go'
		let l:def = "\<C-x>\<C-o>"
	" Keyword complete for anything else
	else
		let l:def = "\<C-x>\<C-n>"
	endif

	" If we have spell suggestions for the current work, use that. Otherwise use
	" whatever we figured out above.
	try
		if spellbadword()[1] != ''
			return "\<C-x>s"
		else
			return l:def
		endif
	catch
		return l:def
	endtry
endfun
inoremap <expr> <C-@>  pumvisible() ?  "\<C-n>" : GuessType()
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"
nnoremap <expr> <C-@> pumvisible() ?  "i\<C-n>" : 'i' . GuessType()

