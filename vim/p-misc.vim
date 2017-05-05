" $dotid$

" unicode: prevent overriding thing mapping 
nnoremap <F13> <Plug>(MakeDigraph) | vnoremap <F13> <Plug>(MakeDigraph)

" LargeFile: consider it to be a "large" file is larger than this amount of MB
let g:LargeFile = 10

" Don't enable by default
let g:gitgutter_enabled = 0
let g:gitgutter_override_sign_column_highlight = 0

" Use system tool intead of downloading our own
let g:grammarous#languagetool_cmd = 'languagetool'
