" alias nvim nvim -u ~/.vim/vimrc
if !has('nvim')
    finish
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
"set viminfo+=.nvim


" vim:expandtab
