" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :

nnoremap <F2> :registers<CR>
nnoremap <F3> :set cursorcolumn!<CR>
nnoremap <F4> :jumps<CR>
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <F6> :marks<CR>
nnoremap <F10> :set list!<CR>
nnoremap <F12> :set paste!<CR>

" Enable spell check, switch languages
nmap <Leader>ss :set spell!<CR>
nmap <Leader>sn :set spelllang=nl<CR>
nmap <Leader>se :set spelllang=en_gb<CR>

" Show all matches of word under cursor
map <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-L> to clear some hightlighting
nnoremap <silent> <C-L> :nohlsearch<CR>:set nolist nospell<CR><C-L>

" We don't need no stinkin' ex mode; use it for formatting
map Q gq

" Interface with system clipboard
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Indent in visual and select mode automatically re-selects
vnoremap > >gv
vnoremap < <gv

" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Use arrows keys for visual movement
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

" Easier :make
noremap ,b :make<CR>

" Open multiple tabs at one
command! -bar -bang -nargs=+ -complete=file Tabedit call OpenMultipleTabs("<args>")
command! WriteMode call WriteMode()
