scriptencoding utf-8

" Navigate the quickfix or location list.
"
" These are right, left, up, and down arrow keys with Control.
" Using <C-Up> etc. doesn't seem to work.

" Some machines send these escape codes..
nnoremap <silent> [C :call <SID>listmove('next', 1)<CR>
nnoremap <silent> [D :call <SID>listmove('prev', 1)<CR>
nnoremap <silent> [A :call <SID>listtoggle('open')<CR>
nnoremap <silent> [B :call <SID>listtoggle('close')<CR>

" .. and others send these.
nnoremap <silent> [1;5C :call <SID>listmove('next', 1)<CR>
nnoremap <silent> [1;5D :call <SID>listmove('prev', 1)<CR>
nnoremap <silent> [1;5A :call <SID>listtoggle('open')<CR>
nnoremap <silent> [1;5B :call <SID>listtoggle('close')<CR>

command! -bar -count=1 ListNext call <SID>listmove('next', <count>)
command! -bar -count=1 ListPrev call <SID>listmove('prev', <count>)

" Move to the next or previos item, depending on cursor position.
" Based on: https://vi.stackexchange.com/a/14359/51
fun! s:listmove(dir, count) abort
    " Try location list first, and fall back to location list if it doesn't
    " exist.
    let l:list = getloclist(0)
    let l:current = getloclist(0, {'idx': 1})
    let l:cmd = 'll'
    if len(l:list) is 0
        let l:list = getqflist()
        let l:current = getqflist({'idx': 1})
        let l:cmd = 'cc'
    endif
    if len(l:list) is 0
        echohl ErrorMsg | echom 'E42: No Errors' | echohl None
        return
    endif

    " Currently active item in the list.
    let l:current = l:current.idx - 1

    " Add index to list
    call map(l:list, {k, v -> extend(l:v, {'idx': l:k})})

    if a:dir is? 'next'
        " Remove all items before the current entry.
        call filter(l:list, {i, v -> l:v.bufnr is# bufnr('') && line('.') < l:v.lnum})
        "call filter(l:list, {i, v -> l:v.bufnr is# bufnr('') && line('.') < l:v.lnum && col('.') <= l:v.col})
        let l:idx = get(get(l:list, 0, {}), 'idx', l:current)
    else
        " Remove all items after the current entry.
        call filter(l:list, {i, v -> l:v.bufnr == bufnr('') && line('.') > l:v.lnum})
        "call filter(l:list, {i, v -> l:v.bufnr == bufnr('') && line('.') > l:v.lnum && col('.') >= l:v.col})
        let l:idx = get(get(l:list, len(l:list)-1, {}), 'idx', l:current)
    endif

    if len(l:list) is 0
        echohl ErrorMsg | echom 'E553: No more items' | echohl None
        return
    endif

    " + 1 because list items start at 1.
    silent execute l:cmd . (l:idx + 1)
endfun

" Open or close the quickfix or locationlist.
fun! s:listtoggle(dir) abort
    let l:len = len(getloclist(0))
    let l:qf = 'l'
    if l:len is 0
        let l:qf = 'c'
        let l:len = len(getqflist())
    endif
    if l:len is 0
        echohl ErrorMsg | echom 'E42: No Errors' | echohl None
        return
    endif

    if a:dir is? 'close'
        exe ':' . l:qf . 'close'
    else
        exe ':' . l:qf . 'open ' . min([l:len, 10])
        " Leave the cursor alone!
        wincmd w
    endif
endfun
