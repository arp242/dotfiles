" $dotid"

" Reload config
nnoremap <Leader>r :source $MYVIMRC<CR>

" Close help, rather than open help, on F1
nnoremap <F1> :helpclose<CR>
inoremap <F1> <Esc>:helpclose<CR>a

" List all registers
nnoremap <F2> :registers<CR>

" Show undo tree
nnoremap <F3> :UndotreeToggle<CR>

" Toggle Syntastic (I have it enabled by default)
nnoremap <F4> :SyntasticToggleMode<CR>

" Set list
nnoremap <F10> :set list!<CR>

" Show indentation guides
nnoremap <F11> :IndentLinesToggle<CR>

" Set paste with ease
nnoremap <F12> :set paste!<CR>

" Make sure that <F12> also works when set paste is enabled
set pastetoggle=<F12>

" Enable spell check, switch languages
nnoremap <Leader>ss :set spell!<CR>
nnoremap <Leader>snl :set spelllang=nl<CR>
nnoremap <Leader>sen :set spelllang=en_gb<CR>

" Show all matches of word under cursor
nnoremap <Leader>f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>

" Use <C-L> to clear some highlighting
nnoremap <silent> <C-L> :nohlsearch<CR>:set nolist nospell<CR><C-L>

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

" Hex read
nnoremap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nnoremap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Use arrows keys for visual movement
nnoremap <C-k> gk
nnoremap <C-j> gj

"inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>l
inoremap <C-k> <C-o>gk
inoremap <C-j> <C-o>gj

" Write as root user
nnoremap <Leader>w! :call SuperWrite()<CR>

" Make the directory tree to the current file; if it doesn't exist
nnoremap <Leader>m :call mkdir(expand("%:p:h"), "p")<CR>

" Easier :make (b for build)
nnoremap <Leader>b :make<CR>

" Join with no spaces
nnoremap <Leader>J :call JoinSpaceless()<CR>

" Browse
nnoremap <Leader>o :browse oldfiles<CR>

" Increment only the digit underneath the cursor
nnoremap <C-a> :call search('\d', 'c')<CR>a <Esc>h<C-a>lxh
nnoremap <C-x> :call search('\d', 'c')<CR>a <Esc>h<C-x>lxh

" gf opens in a tab
nnoremap gf <C-w>gf
vnoremap gf <C-w>gf


" https://github.com/tpope/vim-speeddating
fun! Increment()
	" Search for a number on the current line
	if !search('\d', 'c', getline('.'))
		return
	endif

	" Add spaces around the number
	%s/\%#\d\+/ \0 /

	" Increment the number
	execute "normal! \<C-a>"

	" Remove the spaces
	"call search(' ', 'b', getline('.'))
	"%s/\%# \(\d\+\) /\1/

	"let b:current_search = matchadd('CurrentSearch', '\c\%#' . @/, 666)

	"execute "normal! i "

	" TODO: Don't add space at end of line

	"call search('[^[:digit:]]', '', getline('.'))
	"execute "normal! i "

	"normal h
	"execute "normal! \<C-a>"
endfun

"nnoremap <C-a> :call Increment()<CR>

"a <Esc>h
"<C-a>lxh
"nnoremap <C-x> :call search('\d', 'c')<CR>a <Esc>h<C-x>lxh
