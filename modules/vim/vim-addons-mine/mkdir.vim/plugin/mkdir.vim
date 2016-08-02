" https://github.com/vim-scripts/auto_mkdir

" Make directory if it doesn't exist yet
fun! MkdirIfNeeded(dir, flags, permissions)
    if !isdirectory(a:dir)
        call mkdir(a:dir, a:flags, a:permissions)
    endif
endfun

" Make the directory tree to the current file; if it doesn't exist
nnoremap <Leader>m :call mkdir(expand("%:p:h"), "p")<CR>
