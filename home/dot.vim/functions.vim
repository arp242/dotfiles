" Make directory if it doesn't exist yet
fun! MkdirIfNeeded(dir, flags, permissions)
	if !isdirectory(a:dir)
		call mkdir(a:dir, a:flags, a:permissions)
	endif
endfun


" Map key to toggle an option on/off
fun! MapToggle(key, opt)
	let l:cmd = ':set ' . a:opt . '! \| set ' . a:opt . "?\<CR>"
	exec 'nnoremap ' . a:key . ' ' . l:cmd
	exec 'inoremap ' . a:key . " \<C-O>" . l:cmd
endfun
command! -nargs=+ MapToggle call MapToggle(<f-args>)


" Replace `} else {' with `}<CR>else {'
fun! SaneIndent()
	silent! %s/\v(\s*)}\s*(else|catch)/\1}\r\1\2/g
	execute "normal ''"
endfun


" Replace `}<CR>else {' with `} else {'
fun! NotSoSaneIndent()
	silent! %s/\v}\_.(\s*)(else|catch)/} \2/g
	execute "normal ''"
endfun


" Open multiple tabs at one
fun! OpenMultipleTabs(pattern)
	for p in split(a:pattern, ' ')
		let l:files = split(glob(l:p), '\n')
		call map(l:files, "'tabe ' . v:val")
		for c in l:files | exe c | endfor
	endfor
endfun


" :retab changes *everything*, not just start of lines
fun! Retab(expandtab)
	let l:spaces = repeat(' ', &tabstop)

	" Replace tabs with spaces
	if a:expandtab
		silent! execute '%substitute#^\%(' . l:spaces . '\)\+#\=repeat("\t", len(submatch(0)) / &tabstop)#e'
	" Replace spaces with tabs
	else
		silent! execute '%substitute#^\%(\t\)\+#\=repeat("' . l:spaces . '", len(submatch(0)))#e'
	endif
endfun
