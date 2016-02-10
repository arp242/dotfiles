" Reload config
nnoremap <Leader>r :source $MYVIMRC<CR>

" Close help, rather than open help, on F1
nnoremap <F1> :helpclose<CR>
inoremap <F1> <C-o>:helpclose<CR>

nnoremap <F2> :registers<CR>
nnoremap <F3> :UndotreeToggle<CR>
nnoremap <F4> :SyntasticToggleMode<CR>

" We need this to prevent the unicode plugin from overriding it
nnoremap <F13> <Plug>(MakeDigraph) | vnoremap <F13> <Plug>(MakeDigraph)

nnoremap <F10> :set list!<CR>
nnoremap <F11> :set cursorcolumn!<CR>
nnoremap <F12> :set paste!<CR>

" Make sure that <F12> also works when set paste is enabled
set pastetoggle=<F12>

" Enable spell check, switch languages
nnoremap <Leader>ss :set spell!<CR>
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

" Hex read
nnoremap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nnoremap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Use arrows keys for visual movement
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Easier
inoremap <C-k> <C-y>
inoremap <C-j> <C-e>

" Write as root user
"nnoremap <Leader>w! :call SuperWrite()<CR>

" Join with no spaces
nnoremap <Leader>J :call JoinSpaceless()<CR>

" Browse
nnoremap <Leader>o :browse oldfiles<CR>

" gf opens in a tab
nnoremap gf <C-w>gf
vnoremap gf <C-w>gf

" Better?
" http://www.vim.org/scripts/script.php?script_id=2294
nnoremap <C-q> :ToggleWord<CR>
inoremap <C-q> <C-o>:ToggleWord<CR>

let g:_toggle_words_dict = {'*': [
    \ ['==', '!='], 
    \ ['>', '<'], 
    \ ['(', ')'], 
    \ ['[', ']'], 
    \ ['{', '}'], 
    \ ['+', '-'], 
    \ ['allow', 'deny'], 
    \ ['before', 'after'], 
    \ ['define', 'undef'], 
    \ ['if', 'elseif'], 
    \ ['in', 'out'], 
    \ ['left', 'right'],
    \ ['min', 'max'], 
    \ ['on', 'off'], 
    \ ['start', 'stop'], 
    \ ['success', 'failure'], 
    \ ['true', 'false'],
    \ ['up', 'down'], 
    \ ['left', 'right'],
    \ ['yes', 'no'], 
    \ ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'], 
    \ ['january', 'february', 'march', 'april', 'may', 'june', 'july', 'august', 'september', 'october', 'november', 'december'], 
    \ ['1', '0'],
    \ [],
    \ ],  }

" I often mistype this :-/
cabbr Set set

" Always open :help in a new tab
"cabbr help tab help


" https://github.com/tpope/vim-speeddating
fun! Increment(dir, count)
	" No number on the current line
	if !search('\d', 'c', getline('.'))
		return
	endif

	" Store cursor position
	let l:save_pos = getpos('.')

	" Add spaces around the number
	s/\%#\d/ \0 /
	call setpos('.', l:save_pos)
	normal! l

	" Increment or decrement the number
	if a:dir == 'prev'
		execute "normal! " . repeat("\<C-x>"), a:count
	else
		execute "normal! " . repeat("\<C-a>", a:count)
	endif

	" Remove the spaces
	s/\v (\d{-})%#(\d) /\1\2/

	" Restore cursor position
	call setpos('.', l:save_pos)
endfun

nnoremap <silent> g<C-a> :<C-u>call Increment('next', v:count1)<CR>
nnoremap <silent> g<C-x> :<C-u>call Increment('prev', v:count1)<CR>
