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

augroup my-dirvish
    au!
    au Filetype dirvish
                "\ Remap as I often use q to close the Vim pager.
                \  silent! nunmap <buffer> q
                \| nmap <buffer> Q <Plug>(dirvish_quit)
                "\ Add tab mappings
                \| nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
                \| xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
                "\ Launch shell in cwd
                \| nnoremap <buffer> <C-t> :lcd %<CR>:silent exec '!' . (has('gui_running') ? 'st -e ' : '') . $SHELL<CR>:lcd<CR><C-l>
augroup end


""" gopher.vim
""""""""""""""
let g:gopher_debug = ['commands']
let g:gopher_highlight = ['string-spell', 'string-fmt', 'fold-import', 'fold-pkg-comment']
"let g:gopher_build_tags = ['testdb']
"let g:gopher_override_vimgo = 1

augroup my-gopher
    au!

    " Make, lint, and test code.
    au FileType go nnoremap MM :wa<CR>:compiler go<CR>:silent make!<CR>:redraw!<CR>
    au FileType go nnoremap LL :wa<CR>:compiler golint<CR>:silent make!<CR>:redraw!<CR>
    au FileType go nnoremap TT :wa<CR>:compiler gotest<CR>:silent make!<CR>:redraw!<CR>

    " Lint on write.
    "au BufWritePost *.go compiler golint | silent make! | redraw!

    " Format buffer on write.
    au BufWritePre *.go
                \  let s:save = winsaveview()
                \| exe 'keepjumps %!goimports 2>/dev/null || cat /dev/stdin'
                \| call winrestview(s:save)
augroup end

""" vim-qf
""""""""""
let g:qf_auto_open_quickfix = 1        " Automatically open qfix and loclist.
let g:qf_auto_open_loclist = 1

" Go to next/prev error; need to use escape codes as <C-Arrow> isn't reliable.
nmap <C-Left>    <Plug>(qf_qf_previous)
nmap <Esc>[D >   <Plug>(qf_qf_previous)
nmap <Esc>[1;5D  <Plug>(qf_qf_previous)
nmap <C-Right>   <Plug>(qf_qf_next)
nmap <Esc>[C     <Plug>(qf_qf_next)
nmap <Esc>[1;5C  <Plug>(qf_qf_next)

" Toggle location list.
nmap <C-Up>      <Plug>(qf_qf_toggle_stay)
nmap <Esc>[A     <Plug>(qf_qf_toggle_stay)
nmap <Esc>[1;5A  <Plug>(qf_qf_toggle_stay)

" TODO: Make <C-Down> switch above mappings to loclist.
" nnoremap <C-Down>
" nnoremap <Esc>[B
" nnoremap <Esc>[1;5B


""" vim-lsc
"""""""""""
" Use full path as I modified this one to emit less useless status messages.
let g:lsc_server_commands = {'go': '/home/martin/go/bin/bingo -diagnostics-style none -enhance-signature-help'}

let g:lsc_enable_autocomplete = v:false      " Don't complete when typing.
let g:lsc_enable_diagnostics = v:false       " Don't lint code.
let g:lsc_preview_split_direction = 'below'  " Show preview at bottom, rather than top.

let g:lsc_auto_map = {'defaults': v:true, 'SignatureHelp': '<C-k>', 'GoToDefinitionSplit': ''}
augroup my-lsc
    au!
    au BufNewFile,BufReadPost *
        \  if has_key(get(g:, 'lsc_servers_by_filetype', {}), &filetype) && lsc#server#filetypeActive(&filetype)
        "\     Show function signature in insert mode too (I don't use digraphs).
        \|     inoremap <buffer> <C-k> <C-o>:LSClientSignatureHelp<CR>
        "\     Open in tab, rather than split.
        \|     nnoremap <buffer> <C-w>]     :tab LSClientGoToDefinitionSplit<CR>
        \|     nnoremap <buffer> <C-w><C-]> :tab LSClientGoToDefinitionSplit<CR>
        \|     nnoremap <buffer> gd         :tab LSClientGoToDefinitionSplit<CR>
        \| endif

    " Resize to be as small as possible.
    au WinLeave __lsc_preview__ exe 'resize ' . min([&previewheight, line('$')])
    au User LSCShowPreview      exe 'resize ' . min([&previewheight, line('$')])
augroup end


""" neoformat
"""""""""""""
let g:neoformat_only_msg_on_error = 1  " Only message on errors.

augroup my-neoformat
    au!
    au BufWritePre * undojoin | Neoformat
augroup END


""" typescript-vim
""""""""""""""""""
augroup my-typescript
    au!
    " Strict compiler options.
    au Filetype typescript let g:typescript_compiler_options = join([
                \ '--strict',
                \ '--noImplicitAny',
                \ '--noImplicitThis',
                \ '--noUnusedLocals',
                \ '--noImplicitReturns',
                \ '--noFallthroughCasesInSwitch',
                \ ],' ')
augroup end


" vim:expandtab
