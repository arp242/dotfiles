" $dotid$

" Reload config
nnoremap <Leader>r :source $MYVIMRC<CR>

" Close help, rather than open help, on F1
nnoremap <F1> :helpclose<CR>
inoremap <F1> <Esc>:helpclose<CR>a

" List all registers
nnoremap <F2> :registers<CR>

" Show undo tree
nnoremap <F3> :UndotreeToggle<cr>

" Set list
nnoremap <F10> :set list!<CR>

" Show indentation guides
nnoremap <F11> :IndentLinesToggle<CR>

" Set paste with ease
" TODO: Could be better ... see :help paste, :help pastetoggle
nnoremap <F12> :set paste!<CR>
inoremap <F12> <Esc>:set paste!<CR>a

" Enable spell check, switch languages
nmap <Leader>ss :set spell!<CR>
nmap <Leader>sn :set spelllang=nl<CR>
nmap <Leader>se :set spelllang=en_gb<CR>

" Show all matches of word under cursor
map <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-L> to clear some highlighting
nnoremap <silent> <C-L> :nohlsearch<CR>:set nolist nospell<CR><C-L>

" We don't need no stinkin' ex mode; use it for formatting
map Q gq

" Interface with system clipboard
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>Y "+y
nnoremap <Leader>P "+p

" Indent in visual and select mode automatically re-selects
vnoremap > >gv
vnoremap < <gv

" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Use arrows keys for visual movement
" TODO: Also set these for insert mode
nnoremap <Up> gk
nnoremap <Down> gj

" Write as root user
nnoremap <Leader>w! :call SuperWrite()<CR>

" Visually move blocks of text
vmap <expr> <C-Left> DVB_Drag('left')
vmap <expr> <C-Right> DVB_Drag('right')
vmap <expr> <C-Down> DVB_Drag('down')
vmap <expr> <C-Up> DVB_Drag('up')
vmap <expr> D DVB_Duplicate()

" Make the directory tree to the current file; if it doesn't exist
nmap <Leader>m :call mkdir(expand("%:p:h"), "p")<CR>

" Easier :make (b for build)
noremap <Leader>b :make<CR>

" Join with no spaces
nnoremap <Leader>J :call JoinSpaceless()<CR>

" Browse
nnoremap <Leader>o :browse oldfiles<CR>
