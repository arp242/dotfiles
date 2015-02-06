" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :

nnoremap <F2> :registers<CR>
"nnoremap <F3> :BufExplorer<CR>
nnoremap <F4> :jumps<CR>
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <F6> :marks<CR>
MapToggle <F7> cursorcolumn
MapToggle <F10> list
MapToggle <F12> paste

" Enable spell check, switch languages
nmap <Leader>ss :set spell!<CR>
nmap <Leader>sn :set spelllang=nl<CR>
nmap <Leader>se :set spelllang=en_gb<CR>

" Show all matches of word under cursor
map <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-L> to clear the highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" We don't need no stinkin' ex mode; use it for formatting
map Q gq

" Interface with system clipboard
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Indent in visual and select mode automatically re-selects
vnoremap > >gv
vnoremap < <gv

" Open multiple tabs at one
command! -bar -bang -nargs=+ -complete=file Tabedit call OpenMultipleTabs("<args>")

" Switch environments
nmap <Leader>pw :let env = "work"<CR>:source $MYVIMRC<CR>
nmap <Leader>pp :let env = "personal"<CR>:source $MYVIMRC<CR>

" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Use arrows keys for visual movement
nnoremap <Up> gk
nnoremap <Down> gj

" Write as root user
nnoremap <Leader>w! :call SuperWrite()<CR>

map _i :call Paste_Func()<CR>
