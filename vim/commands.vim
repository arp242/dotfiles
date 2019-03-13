" :retab changes *everything*; this changes *only* indentation (and not stuff
" inside strings or for alignment)
fun! s:retab()
	let l:save = winsaveview('.')
	let l:spaces = repeat(' ', &tabstop)

	" Replace tabs with spaces
	if &expandtab
		silent! execute '%substitute#^\%(' . l:spaces . '\)\+#\=repeat("\t", len(submatch(0)) / &tabstop)#e'
	" Replace spaces with tabs
	else
		silent! execute '%substitute#^\%(\t\)\+#\=repeat("' . l:spaces . '", len(submatch(0)))#e'
	endif
	call winrestview(l:save)
endfun
command! Retab call s:retab()

" Write as root user; re-read file.
fun! s:super_write()
	silent write !doas tee %
	edit!
endfun
command! SuperWrite call s:super_write()

" Clean trailing whitespace.
fun! s:trim_whitespace()
	let l:save = winsaveview()
	keeppattern %s/\s\+$//e
	call winrestview(l:save)
endfun
command! TrimWhitespace call s:trim_whitespace()

" Move a file and update buffer.
fun! s:mv(dest)
	let l:src = expand('%:p')
	if a:dest isnot# ''
		let l:dest = expand(a:dest)
	else
		let l:dest = expand(input('New file name: ', expand('%:p'), 'file'))
	endif

	if !isdirectory(fnamemodify(l:dest, ':h'))
		call mkdir(fnamemodify(l:dest, ':h'), 'p')
	endif

    if rename(l:src, l:dest) == 0
		execute 'edit ' . l:dest
	endif
endfun
command! -nargs=? -complete=file Mv call s:mv(<q-args>)

" vsplit the current buffer, move the right buffer a page down, and set
" scrollbind.
fun! s:scroll()
	let l:save = &scrolloff

	set scrolloff=0 noscrollbind
	"nowrap nofoldenable
	botright vsplit

	normal! L
	normal! j
	normal! zt

	setlocal scrollbind
	exe "normal \<c-w>p"
	setlocal scrollbind

	let &scrolloff = l:save
endfun
command! Scroll call s:scroll()

" Get the syntax name of character under the cursor
command! SyntaxName :echo synIDattr(synID(line('.'), col('.'), 1), 'name')

" Easier diff copy
command! DG :1,$+1diffget

" Load all optional packages too before running :helptags ALL.
command! -nargs=0 -bar Helptags
		\  for p in glob('~/.vim/pack/bundle/opt/*', 1, 1)
		\|     exe 'packadd ' . fnamemodify(p, ':t')
		\| endfor
		\| helptags ALL
