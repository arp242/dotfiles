" unicode: prevent overriding thing mapping
nnoremap <F13> <Plug>(MakeDigraph) | vnoremap <F13> <Plug>(MakeDigraph)

" LargeFile: consider it to be a "large" file is larger than this amount of MB
let g:LargeFile = 5

" TODO: add command/function for this; don't like the formatting in stl.
" :echo matchup#delim#get_current('all', 'both_all'):
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_matchparen_deferred = 1
