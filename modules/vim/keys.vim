" Quickly jump to recently used filed
nnoremap <Leader>o :browse oldfiles<CR>

" Reload config
nnoremap <Leader>r :source $MYVIMRC<CR>

" Close help, rather than open help
nnoremap <F1> :helpclose<CR>
inoremap <F1> <C-o>:helpclose<CR>

nnoremap <F2> :registers<CR>
nnoremap <F3> :UndotreeToggle<CR>
nnoremap <F4> :SyntasticToggleMode<CR>

nnoremap <F10> :set list!<CR>:set list?<CR>
nnoremap <F11> :set cursorcolumn!<CR>:set cursorcolumn?<CR>
nnoremap <F12> :set paste!<CR>:set paste?<CR>

" Make sure that <F12> also works when set paste is enabled
set pastetoggle=<F12>

" Enable spell check, switch languages
nnoremap <Leader>ss :set spell!<CR>:set spell?<CR>
nnoremap <Leader>sn :set spelllang=nl<CR>
nnoremap <Leader>se :set spelllang=en_gb<CR>
nnoremap <Leader>su :set spelllang=en_us<CR>
nnoremap <Leader>sd :set spelllang=de_de<CR>

" Show all matches of word under cursor
nnoremap <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-l> to clear some highlighting
nnoremap <silent> <C-l> :nohlsearch<CR>:set nolist nospell<CR><C-l>

" We don't need no stinkin' ex mode; use it for formatting
noremap Q gq

" Interface with system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Indent in visual and select mode automatically re-selects
vnoremap > >gv
vnoremap < <gv

" Use visual movement rather than line movement
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" gf opens in a tab
nnoremap gf <C-w>gf
vnoremap gf <C-w>gf

" TODO: It looks like I'm reinventing the wheel
" http://www.vim.org/scripts/script.php?script_id=5184
fun! GuessType()
	try
		if spellbadword()[1] != '' | return "\<C-x>s"
		else | return "\<C-x>\<C-n>"
		endif
	catch
		return "\<C-x>\<C-n>"
	endtry
endfun
inoremap <expr> <C-@>  pumvisible() ?  "\<C-n>" : GuessType()
inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up> pumvisible() ? "\<C-n>" : "\<Up>"
nnoremap <expr> <C-@> pumvisible() ?  "i\<C-n>" : 'i' . GuessType()

" Run shell command with \c on visual selection
" TODO: Pluginify
xnoremap <expr> <Leader>c "\<Esc>:'<,'>:w !" . getbufvar('%', 'run_command', &filetype) . "\<CR>"

" I often mistype this :-/
cabbr Set set
cabbr Help help
