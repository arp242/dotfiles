" Reload config.
nnoremap <Leader>r :source $MYVIMRC<CR>

" Close help, rather than open help.
nnoremap <F1> :helpclose<CR>
inoremap <F1> <C-o>:helpclose<CR>
nnoremap <F4> :ALEToggle<CR>

" Some useful-ish toggles.
nnoremap <F9>  :set shiftround!<CR>:set shiftround?<CR>
inoremap <F9>  <C-o>:set shiftround!<CR>
nnoremap <F10> :set list!<CR>:set list?<CR>
inoremap <F10> <C-o>:set list!<CR>
nnoremap <F11> :set cursorcolumn!<CR>:set cursorcolumn?<CR>
inoremap <F11> <C-o>:set cursorcolumn!<CR>
nnoremap <F12> :set cursorline!<CR>:set cursorline?<CR>
inoremap <F12> <C-o>:set cursorline!<CR>

" Enable spell check, switch languages
nnoremap <Leader>ss :set spell!<CR>:set spell?<CR>
nnoremap <Leader>sn :set spelllang=nl<CR>
nnoremap <Leader>se :set spelllang=en_gb<CR>
nnoremap <Leader>su :set spelllang=en_us<CR>
nnoremap <Leader>sd :set spelllang=de_de<CR>

" Use <C-l> to clear some highlighting.
nnoremap <silent> <C-l> :nohlsearch<CR>:setl nolist nospell<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>

" We don't need no stinkin' ex mode; use it for formatting
noremap Q gq

" Bloody annoying.
nnoremap q: :q

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

" Home works like 0 if already at start of a line, and ^ otherwise.
" Adapted from: http://vim.wikia.com/wiki/VimTip315
noremap <expr> <Home> col('.') is# match(getline('.'), '\S') + 1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Workaround to map <Home> in xterm outside of tmux on my system.
if &term == "xterm-256color"
	set <Home>=OH
	set <xHome>=OH
endif

" Replace the current line with the unnamed register without affecting any
" register.
nnoremap RR "_ddP

" I often mistype this :-/
cabbr Set set
cabbr Help help

" My fingers just can't get this stupid thing right :-/
iabbr teh the
iabbr Teh The
iabbr taht that

" Makes Go a bit easier to program.
iabbr 1= !=
iabbr ;= :=

" Basic context completion with Ctrl-Space
fun! s:guessType()
	if &spell && spellbadword()[1] isnot# ''
		" TODO: Show word somewhere
		" TODO: Make completion start even if word is after badly spelled word.
		return "\<C-x>s"
	elseif &omnifunc isnot# ''
		return "\<C-x>\<C-o>"
	else
		return "\<C-x>\<C-n>"
	endif
endfun
inoremap <expr> <C-@>  pumvisible() ? "\<C-n>"  : <SID>guessType()
inoremap <expr> <Down> pumvisible() ? "\<C-n>"  : "\<Down>"
inoremap <expr> <Up>   pumvisible() ? "\<C-p>"  : "\<Up>"
nnoremap <expr> <C-@>  pumvisible() ? "i\<C-n>" : 'i' . <SID>guessType()
