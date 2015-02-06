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


" Clean trailing whitespace
fun! CleanWhitespace()
	:%s/\s\+$//e
endfun


" Make help link (markdown format)
fun! Helplink()
	" Get the name of the tag, With help from:
	" https://vi.stackexchange.com/questions/434/get-name-of-nearest-tag-to-the-cursor
	if !search('\*\zs[^*]\+\*$', 'bW')
		echoerr "No tag found"
	endif
	let l:line = getline('.')
	let l:start = col('.') - 1
	call search('\*', '', line('.'))
	let l:len =  col('.') - l:start - 1
	let l:tagname = strpart(l:line, l:start, l:len)

	let l:tagname_esc = system('echo -n ' . shellescape(l:tagname) . ' | python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.stdin.read()), end=' . "''" . ')"')
	let l:file = split(expand('%'), '/')[-1]
	let l:url = "http://vimhelp.appspot.com/" . l:file . ".html#" . l:tagname_esc
	let l:md = '[`:help ' . l:tagname . '`](' . l:url . ')'

	" Copy it to the clipboard
	let @+ = l:md

	return l:md
endfun


" Write as root user; re-read file
fun! SuperWrite()
	:w !sudo tee %
	:e!
endfun


" Make Vim ask for the password again if it's wrong
fun! Check_Enc()
	if &l:cm != ""
		if getline(1) != '' && line("$") < 3 + (line2byte(line("$")) / 100)
			set key=
			edit
			call Check_Enc()
		endif
	endif
endfun


fun! Paste_Func()
	let s:inPaste = &paste
	if !s:inPaste
		set paste
	endif

	echom s:inPaste
	augroup paste_callback
		autocmd!
		autocmd InsertLeave <buffer> call Paste_End()
	augroup END

	startinsert
endfun

fun! Paste_End()
	augroup paste_callback
		autocmd!
	augroup END
	augroup! paste_callback

	if !s:inPaste
		set nopaste
	endif
endfun
