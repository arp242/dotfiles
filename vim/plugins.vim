" Default plugins
"""""""""""""""""
let g:loaded_2html_plugin = 1          " Disable some of the default plugins that I don't use.
let g:loaded_LogiPat = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_man = 1
let g:loaded_netrw = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_rrhelper = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

let g:did_install_default_menus = 1    " We don't use the menus (this is comparatively slow)


""" vim-dirvish
"""""""""""""""
let g:dirvish_relative_paths = 1       " Make paths in the Dirvish buffer relative to getcwd().

augroup dirvish_local
	autocmd!
	autocmd Filetype dirvish call s:dirvish()
augroup end
fun! s:dirvish() abort
	" Remap as I often use q to close the Vim pager (any key will do, but q is
	" my habbit).
	silent! nunmap <buffer> q
	nmap <buffer> Q <Plug>(dirvish_quit)

	" Add tab mappings
	nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
	xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>

	" Launch shell in cwd
	nnoremap <buffer> <C-t> :lcd %<CR>:silent exec '!' . (has('gui_running') ? 'st -e ' : '') . $SHELL<CR>:lcd<CR><C-l>
endfun


""" gopher.vim
""""""""""""""
let g:gopher_debug = ['commands']
let g:gopher_highlight = []
"let g:gopher_highlight = ['string-spell', 'string-fmt', 'fold-import', 'fold-pkg-comment']


""" vim-qf
""""""""""
"let g:qf_auto_open_quickfix = 1
"let g:qf_auto_open_loclist = 1

" augroup p_misc
" 	autocmd!
" 	" Disable 'number' from vim-qf.
" 	au FileType qf setlocal nonumber
" augroup end


""" vim-lsc
"""""""""""
let g:lsc_server_commands = {'go': 'bingo'}
let g:lsc_enable_autocomplete = v:false
let g:lsc_auto_map = {'defaults': v:true, 'SignatureHelp': '<C-k>'}
inoremap <C-k> <C-o>:LSClientSignatureHelp<CR>

""" typescript-vim
""""""""""""""""""

" Strict compiler options.
let g:typescript_compiler_options = '--strict --noImplicitAny --noImplicitThis --noUnusedLocals --noImplicitReturns --noFallthroughCasesInSwitch'
