

" vim-lookup
augroup p_misc
    autocmd!
    autocmd FileType vim nnoremap <buffer> <silent> gd :call lookup#lookup()<cr>
augroup end

" TODO: add command/function for this; don't like the formatting in stl.
" :echo matchup#delim#get_current('all', 'both_all'):
"let g:matchup_matchparen_status_offscreen = 0
"let g:matchup_matchparen_deferred = 1


" Settings for Vim-go

augroup my_go_settings
    autocmd!

    " Shortcuts for make/test/run.
    "autocmd FileType go nnoremap <buffer> MM :wa<CR>:compiler go<CR>:LmakeJob<CR>
    "autocmd FileType go nnoremap <buffer> TT :wa<CR>:compiler gotest<CR>:LmakeJob<CR>
    "autocmd FileType go nnoremap <buffer> RR :wa<CR>:compiler gorun<CR>:LmakeJob<CR>
    "autocmd FileType go imap <C-@> <Plug>(ale_complete)

    autocmd FileType go nnoremap <buffer> <Leader>a :call <SID>alt()<CR>

    " Set compiler.
    "autocmd FileType go
    "   \  if expand('%')[-8:] is# '_test.go'
    "   \|   compiler gotest
    "   \|   let &l:makeprg = 'go test -tags="testdb testhub"'
    "   \|  else
    "   \|   compiler go
    "   \|   let &l:makeprg = 'go install -tags="testdb testhub"'
    "   \|   let s:d = './cmd/' . fnamemodify(system('go list .')[:-2], ':t')
    "   \|   if isdirectory(s:d)
    "   \|     let &l:makeprg .= ' ' . s:d
    "   \| endif
augroup end

fun! s:alt()
    let l:file = expand('%')
    if empty(l:file)
        return
    elseif l:file[-8:] is# '_test.go'
        let l:alt_file = l:file[:-9] . '.go'
    elseif l:file[-3:] is# '.go'
        let l:alt_file = l:file[:-4] . '_test.go'
    else
        return
    endif

    let l:cmd = 'tabe'
    if bufloaded(l:alt_file)
        let l:cmd = 'sbuffer'
    endif
    exe printf(':%s %s', l:cmd, fnameescape(l:alt_file))
endfun


" Toggle between "single-line" and "normal" if checks:
"
"   err := e()
"   if err != nil {
"
" and:
"
"   if err := e(); err != nil {
"
" TODO: See if we can integrate this in https://github.com/AndrewRadev/splitjoin.vim
" TODO: Check if we can integrate this in expanderr.
fun! s:switch_if()
    let l:line = getline('.')
    if match(l:line, "if ") == -1
        " Try line below current one too.
        let l:line = getline(line('.') + 1)

        if match(l:line, "if ") == -1
            echohl Error | echom "No 'if' in current line" | echohl Normal
            return
        endif

        normal! j
    endif

    let l:line = substitute(l:line, "^\\s*", "", "")
    let l:indent = repeat("\t", indent('.') / 4)

    " Convert "if .. {" to "if ..; err != nil {".
    if match(l:line, ";") == -1
        let l:prev_line = substitute(getline(line('.') - 1), "^\\s*", "", "")
        execute ':' . (line('.') - 1) . 'd _'
        call setline('.', printf('%sif %s; err != nil {', l:indent, l:prev_line))
    " Convert "if ..; err != nil {" to "if .. {".
    else
        let [l:prev_line, l:line] = split(l:line, "; ")
        let l:prev_line = substitute(l:prev_line, "^\\s*", "", "")[3:]
        call setline('.', printf('%sif %s', l:indent, l:line))
        call append(line('.') - 1, printf("%s%s", l:indent, l:prev_line))
    endif
endfun
nnoremap <Leader>e :call <SID>switch_if()<CR>


" vim:expandtab
