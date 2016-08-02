augroup help_start
    autocmd!
    autocmd FileType help call SetHelpFiletype()
augroup end

fun! SetHelpFiletype()
    augroup help_insert
        autocmd!
        autocmd InsertEnter <buffer> setlocal conceallevel=0 | highlight clear Ignore
        autocmd InsertLeave <buffer> setlocal conceallevel=2
    augroup end
endfun
