if exists('g:loaded_syntastic_help_vimhelplint_checker')
    finish
endif
let g:loaded_syntastic_help_vimhelplint_checker = 1

if !exists('g:syntastic_help_vimhelplint_sort')
    let g:syntastic_help_vimhelplint_sort = 1
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_help_vimhelplint_IsAvailable() dict
    return exists('*VimhelpLintGetQflist')
endfunction

function! SyntaxCheckers_help_vimhelplint_GetHighlightRegex(item)
    let pattern = ''
    if a:item.bufnr == bufnr('%')
        if a:item.nr == 1
            let pattern = printf('\%%%dl', a:item.lnum)
        elseif a:item.nr == 2
            let str = matchstr(a:item.text, 'A tag "\zs.\+\ze" is duplicate with another in this file\.')
            let pattern = printf('\%%%dl\%%>%dc%s', a:item.lnum, a:item.col-1, printf('*%s*', str))
        elseif a:item.nr == 3
            let str = matchstr(a:item.text, 'A tag "\zs.\+\ze" is duplicate with another in the file')
            let pattern = printf('\%%%dl\%%>%dc%s', a:item.lnum, a:item.col-1, printf('*%s*', str))
        elseif a:item.nr == 4
            let str = matchstr(a:item.text, 'A link "\zs.\+\ze" does not have a corresponding tag\.')
            let pattern = printf('\%%%dl\%%>%dc%s', a:item.lnum, a:item.col-1, printf('|%s|', str))
        elseif a:item.nr == 5
            let str = matchstr(a:item.text, 'A link "\zs.\+\ze" does not have a corresponding tag\.')
            let pattern = printf('\%%%dl\%%>%dc%s', a:item.lnum, a:item.col-1, printf('|%s|', str))
        elseif a:item.nr == 6
            let str = matchstr(a:item.text, 'There is a tag "\zs.\+\ze". Is it consistent with a link')
            let pattern = printf('\%%%dl\%%>%dc%s', a:item.lnum, a:item.col-1, printf('|%s|', str))
        endif
    endif

    return pattern
endfunction

function! SyntaxCheckers_help_vimhelplint_GetLocList() dict
    return VimhelpLintGetQflist()
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
            \ 'filetype': 'help',
            \ 'name': 'vimhelplint',
            \ 'exec': '' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
