" Reload config.
nnoremap <Leader>r :source $MYVIMRC<CR>

" Some useful-ish toggles.
nnoremap <F9>  :set shiftround!<CR>:set shiftround?<CR>
nnoremap <F10> :set list!<CR>:set list?<CR>
inoremap <F10> <C-o>:set list!<CR>
nnoremap <F11> :set cursorcolumn!<CR>:set cursorcolumn?<CR>
inoremap <F11> <C-o>:set cursorcolumn!<CR>
nnoremap <F12> :set cursorline!<CR>:set cursorline?<CR>
inoremap <F12> <C-o>:set cursorline!<CR>

" Enable spell check, switch languages
nnoremap <F8>      :set spell!<CR>:set spell?<CR>
inoremap <F8>      <C-o>:set spell!<CR>
nnoremap <Leader>ss :set spell!<CR>:set spell?<CR>
nnoremap <Leader>sn :set spelllang=nl<CR>
nnoremap <Leader>se :set spelllang=en_gb<CR>
nnoremap <Leader>su :set spelllang=en_us<CR>
nnoremap <Leader>sd :set spelllang=de_de<CR>

" Use <C-l> to clear some highlighting, and make sure it works from insert mode.
nnoremap <silent> <C-l> :nohlsearch<CR>:setl nolist nospell<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
inoremap <C-l> <C-o>:exe "normal \<C-l>"<CR>

" We don't need no stinkin' ex mode; use it for formatting.
noremap Q gq

" Bloody annoying.
nnoremap q: :q

" Interface with system clipboard.
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" Indent in visual and select mode automatically re-selects.
vnoremap > >gv
vnoremap < <gv

" Use visual movement rather than line movement.
nnoremap k gk
nnoremap j gj
nnoremap <Up>   gk
nnoremap <Down> gj
inoremap <expr> <Up>   pumvisible() ? "\<Up>"    : "\<C-o>gk"
inoremap <expr> <Down> pumvisible() ? "\<Down>"  : "\<C-o>gj"

" gf and gF opens in a tab.
nnoremap gf <C-w>gf
vnoremap gf <C-w>gf
nnoremap gF <C-w>gF
vnoremap gF <C-w>gF

" Home works like 0 if already at start of a line, and ^ otherwise.
" Adapted from: http://vim.wikia.com/wiki/VimTip315
noremap <expr> <Home> col('.') is# match(getline('.'), '\S') + 1 ? '0' : '^'
imap <silent> <Home> <C-O><Home>

" Add guesstimate of reading time to g<C-g>.
fun! s:readtime()
    let l:status = v:statusmsg
    try
        exe "silent normal! g\<C-g>"
        echo printf('%s; About %.0f minutes',
                    \ v:statusmsg, ceil(wordcount()['words'] / 200.0))
    finally
        let v:statusmsg = l:status
    endtry
endfun
nnoremap g<C-g> :call <SID>readtime()<CR>

" Use a reasonable completion.
fun! s:guessType()
    if &spell && spellbadword()[1] isnot# ''
        " TODO: Show original word somewhere.
        " TODO: Make completion start even if word is after badly spelled word.
        return "\<C-x>s"
    elseif &completefunc isnot# ''
        return "\<C-x>\<C-u>"
    elseif &omnifunc isnot# ''
        return "\<C-x>\<C-o>"
    elseif exists('*completor#do')                      " https://github.com/maralla/completor.vim
        return "\<C-R>=completor#do('complete')\<CR>"
    elseif exists(':ALEComplete')                       " https://github.com/w0rp/ale
        return "\<C-\>\<C-O>:ALEComplete\<CR>"
    else
        return "\<C-x>\<C-n>"
    endif
endfun
inoremap <expr> <C-@> pumvisible() ? "\<C-n>"  : <SID>guessType()
nnoremap <expr> <C-@> pumvisible() ? "i\<C-n>" : 'i' . <SID>guessType()

" Don't hijack the entire screen for spell checking, just show the top 8 results
" in the commandline.
" Press 0 for the full list. Any key press that's not a valid option (1-8) will
" behave as normal.
fun! QuickSpell()
	if &spell is 0
        echohl Error | echo "Spell checking not enabled" | echohl None
		return
	endif

	let l:sug = spellsuggest(expand('<cword>'), 8)
	echo join(map(copy(l:sug), {i, v -> printf('%d %s', l:i+1, l:v)}), ' | ')

	let l:char = nr2char(getchar())
    if l:char is# '0'
        normal! z=
        return
    endif

	let l:n = str2nr(l:char)

    " So it's easier to just do "ciw" or whatnot.
    if l:n is 0 || l:n > len(l:sug)
        return feedkeys(l:char)
    endif

    exe printf("normal! ciw%s\<Esc>", l:sug[l:n-1])
    echo
endfun
nnoremap z= :call QuickSpell()<CR>

" Replace the current line with the unnamed register without affecting any
" register.
nnoremap RR "_ddP

" Shortcut to write and run :make.
nnoremap MM :wa<CR>:make<CR>

" Shortcut to close all windows except the current one.
nnoremap <silent> OO :silent wincmd o<CR>

" Format the current line from insert mode.
inoremap <C-f> <C-o>gqk

" I often mistype this :-/
cabbr Set set
cabbr Help help
cabbr tane tabe
cabbr ta tabe
iabbr teh the
iabbr Teh The
iabbr seperated separated
iabbr taht that

" Kind of specific to Go, but doesn't harm to keep as global abbrs.
iabbr ;= :=
iabbr err1= err !=
iabbr err!= err !=

" Makes stuff a bit easier to type.
iabbr 1= !=

" Make these common shortcuts work in the commandline.
cnoremap <C-a> <Home>
"cnoremap <C-k>  TODO


" vim:expandtab
