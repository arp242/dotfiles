" Use ; for : in normal and visual mode, less keystrokes
nnoremap ; :
vnoremap ; :


nnoremap <F2> :registers<CR>
nnoremap <F3> :BufExplorer<CR>
nnoremap <F4> :jumps<CR>
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <F6> :marks<CR>
MapToggle <F7> cursorcolumn
MapToggle <F10> list
MapToggle <F12> paste

nmap <Leader>sn :set spelllang=nl<CR>
nmap <Leader>se :set spelllang=en_gb<CR>
nmap <Leader>ss :set spell!<CR>

" Show all matches of word under cursor
map <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-L> to clear the highlighting of :set hlsearch
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" We don't need no stinkin' ex mode; use it for formatting
map Q gq

nnoremap <Leader>r :call LastCommand()<CR>

" Interface with system clipboard
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>P "*P

" Center buffer on cursor
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Indent in visual and select mode automatically re-selects
vnoremap > >gv
vnoremap < <gv

" Open multiple tabs at one
command! -bar -bang -nargs=+ -complete=file Tabedit call OpenMultipleTabs("<args>")
