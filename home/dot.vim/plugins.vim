call plug#begin('~/.vim/plugged')

Plug 'kien/tabman.vim'
Plug 'mbbill/undotree'
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/AnsiEsc.vim'

" Languages
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'rodjek/vim-puppet'
Plug 'slim-template/vim-slim'

call plug#end()


""" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
