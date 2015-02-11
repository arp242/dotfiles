" Number of tabs to remember
let s:remember = 5

" Store the list of recently closed tabs here
let g:recently_closed_tabs = []

nnoremap <Leader>rc :call RecentlyClosedTabs_list()<CR>

" Store the currently open tabs
let g:_tablist = []
fun! RecentlyClosedTabs_store()
	let g:_tablist = []
	tabdo call add(g:_tablist, expand('%:p'))
	" TODO: Leaves me at last tab
endfun


" Called on TabEnter: save a list of the currently open tabs.
fun! RecentlyClosedTabs_enter()
	"call RecentlyClosedTabs_store()
endfun


" Called on TabLeave: Check if the open tabs at the moment are different than
" when entered this tab: if they are, store the missing
fun! RecentlyClosedTabs_leave()
	let l:old = copy(g:_tablist)
	call RecentlyClosedTabs_store()
endfun


" List recently closed tabs
fun! RecentlyClosedTabs_list()
	echo g:recently_closed_tabs
endfun


aug RecentlyClosedTabs
  autocmd!
  autocmd TabEnter * call RecentlyClosedTabs_enter()
  autocmd TabLeave * call RecentlyClosedTabs_leave()
augroup END


"let g:reopenbuf = expand('%:p')
"
"fun! ReopenLastTabEnter()
"  if tabpagenr('$') < g:lasttabcount
"    let g:reopenbuf = g:lastbuf
"  endif
"endfun
"
"fun! ReopenLastTabLeave()
"  let g:lastbuf = expand('%:p')
"  let g:lasttabcount = tabpagenr('$')
"endfun
"
"
"fun! ReopenLastTab()
"  tabnew
"  execute 'buffer' . g:reopenbuf
"endfun
"
"
"" Tab Restore
"nnoremap <leader>tr :call ReopenLastTab()<CR>
