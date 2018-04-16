" vim-lion: map to commands as well.
command! -range -nargs=1 AlignLeft  exe "normal gvgl<args>"
command! -range -nargs=1 AlignRight exe "normal gvgL<args>"

" vim-lookup
autocmd FileType vim nnoremap <buffer> <silent> gd :call lookup#lookup()<cr>

" vim-bookmarks
" TODO: maybe do this?
" https://github.com/MattesGroeger/vim-bookmarks#bookmarks-per-working-directory
let g:bookmark_auto_save_file = expand('$HOME/.vim/tmp/vim-bookmarks')



" TODO: add command/function for this; don't like the formatting in stl.
" :echo matchup#delim#get_current('all', 'both_all'):
"let g:matchup_matchparen_status_offscreen = 0
"let g:matchup_matchparen_deferred = 1
