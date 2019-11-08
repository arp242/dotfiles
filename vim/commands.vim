" Write as root user; re-read file.
command! SuperWrite silent write !doas tee % \| edit

" Get the syntax name of character under the cursor
command! SyntaxName :echo synIDattr(synID(line('.'), col('.'), 1), 'name')

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

" Call uni on current character.
command! UnicodeName echo
         \ system('uni -q i', 
         \      [strcharpart(strpart(getline('.'), col('.') - 1), 0, 1)]
         \ )[:-2]
