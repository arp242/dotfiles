" Highlight the 'current' search pattern different
highlight CurrentSearch term=reverse ctermbg=14 guibg=Cyan

fun! SearchHighlight()
	silent! call matchdelete(b:current_search)
	"let b:current_search = matchadd('CurrentSearch', '\k*\%#\k*', 666)
	let b:current_search = matchadd('CurrentSearch', '\c\%#' . @/, 666)
endfun

fun! SearchNext()
	try
		execute 'normal! ' . 'Nn'[v:searchforward]
	catch /E385:/
		echohl ErrorMsg | echo "E385: search hit BOTTOM without match for: " . @/ | echohl None
	endtry
	call SearchHighlight()
endfun

fun! SearchPrev()
	try
		execute 'normal! ' . 'nN'[v:searchforward]
	catch /E384:/
		echohl ErrorMsg | echo "E384: search hit TOP without match for: " . @/ | echohl None
	endtry
	call SearchHighlight()
endfun

" Highlight entry
nnoremap <silent> n :call SearchNext()<CR>
nnoremap <silent> N :call SearchPrev()<CR>

" Also highlight entry when searching
cnoremap <expr> <CR> getcmdtype() == '/' \|\| getcmdtype() == '?' ?  "<CR>:call SearchHighlight()<CR>" : "<CR>"

" Go to next/previous match *while* searching
"cnoremap <expr> <Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
" TODO
"cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" Use <C-L> to clear some highlighting
nnoremap <silent> <C-L> :silent! call matchdelete(b:current_search)<CR>:nohlsearch<CR>:set nolist nospell<CR><C-L>

" Modify the * and # so it won't move the cursor
" TODO: SearchHighlight() only works if the cursor is at the start of the word
nnoremap <silent> * :set hlsearch<CR>:let @/ = '\<' . expand('<cword>') .  '\>'<CR>:call SearchHighlight()<CR>
nnoremap <silent> # :set hlsearch<CR>:let @/ = '\<' . expand('<cword>') . '\>'<CR>:call SearchHighlight()<CR>

" Clear all custom matches
command! Clearmatches call clearmatches()
