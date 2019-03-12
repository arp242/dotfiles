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
let g:gopher_highlight = ['string-spell', 'string-fmt', 'fold-import', 'fold-pkg-comment']


" TODO: just needed for formatting; perhaps map before use and unmap after?

augroup my_gopher
	au!

	" Make, lint, and test code.
	au FileType go nnoremap MM :wa<CR>:compiler go<CR>:silent make!<CR>:redraw!<CR>
	au FileType go nnoremap LL :wa<CR>:compiler golint<CR>:silent make!<CR>:redraw!<CR>
	au FileType go nnoremap TT :wa<CR>:compiler gotest<CR>:silent make!<CR>:redraw!<CR>

	" Lint on write.
	"autocmd BufWritePost *.go compiler golint | silent make! | redraw!

	" Format buffer on write; need to make a motion for the entire buffer to
	" make this work.
	autocmd BufWritePre *.go
				\  onoremap <buffer> f :<c-u>normal! mzggVG<cr>`z
				\| exe 'normal gqf'
				\| ounmap <buffer> f
augroup end

""" vim-qf
""""""""""
let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

nmap <C-Left>    <Plug>(qf_qf_previous)
nmap <Esc>[D >   <Plug>(qf_qf_previous)
nmap <Esc>[1;5D  <Plug>(qf_qf_previous)

nmap <C-Right>   <Plug>(qf_qf_next)
nmap <Esc>[C     <Plug>(qf_qf_next)
nmap <Esc>[1;5C  <Plug>(qf_qf_next)

nmap <C-Up>      <Plug>(qf_qf_toggle_stay)
nmap <Esc>[A     <Plug>(qf_qf_toggle_stay)
nmap <Esc>[1;5A  <Plug>(qf_qf_toggle_stay)

" TODO: down switches mappings to loclist.
" nnoremap <Esc>[B :call <SID>listtoggle('close')<CR>
" nnoremap <Esc>[1;5B :call <SID>listtoggle('close')<CR>

" augroup my_qf
" 	autocmd!
" 	" Disable 'number' from vim-qf.
" 	au FileType qf setlocal nonumber
" augroup end


""" vim-lsc
"""""""""""
let g:lsc_server_commands = {'go': 'bingo -diagnostics-style none -enhance-signature-help'}
let g:lsc_enable_autocomplete = v:false
let g:lsc_enable_diagnostics = v:false
let g:lsc_auto_map = {'defaults': v:true, 'SignatureHelp': '<C-k>', 'GoToDefinitionSplit': ''}
let g:lsc_preview_split_direction = 'below'
augroup my_lsc
	au!
	au BufNewFile,BufReadPost *
		\  if has_key(g:lsc_servers_by_filetype, &filetype) && lsc#server#filetypeActive(&filetype)
		\|     inoremap <buffer> <C-k> <C-o>:LSClientSignatureHelp<CR>
		\|     nnoremap <buffer> <C-w>]     :tab LSClientGoToDefinitionSplit<CR>
		\|     nnoremap <buffer> <C-w><C-]> :tab LSClientGoToDefinitionSplit<CR>
		\| endif

	" Resize to be as small as possible.
	au WinLeave __lsc_preview__ exe 'resize ' . min([&previewheight, line('$')])
	au User LSCShowPreview      exe 'resize ' . min([&previewheight, line('$')])
augroup end

""" typescript-vim
""""""""""""""""""

" Strict compiler options.
let g:typescript_compiler_options = '--strict --noImplicitAny --noImplicitThis --noUnusedLocals --noImplicitReturns --noFallthroughCasesInSwitch'
