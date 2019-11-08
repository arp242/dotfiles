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


""" switchy.vim
"""""""""""""""
nnoremap <Leader>a :call switchy#switch('tabedit', 'sbuf')<CR>

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
    au FileType go nnoremap MM :silent! :wa<CR>:compiler go<CR>:silent make!<CR>:redraw!<CR>
    au FileType go nnoremap LL :silent! :wa<CR>:compiler golint<CR>:silent make!<CR>:redraw!<CR>
    au FileType go nnoremap TT :silent! :wa<CR>:compiler gotest<CR>:silent make!<CR>:redraw!<CR>

    " Format buffer on write.
    au BufWritePre *.go
                \  let s:save = winsaveview()
                \| exe 'keepjumps %!goimports 2>/dev/null || cat /dev/stdin'
                \| call winrestview(s:save)

    autocmd BufReadPre /home/martin/code/goatcounter/*.go
                \ let g:gopher_install_package = 'zgo.at/goatcounter/cmd/goatcounter'
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
" https://github.com/castwide/solargraph
" https://github.com/redhat-developer/yaml-language-server
let g:lsc_server_commands = {
            \ 'go': #{command: 'gopls serve', log_level: -1},
            \ }

"\ https://github.com/mads-hartmann/bash-language-server
" \ 'sh':     #{command: 'bash-language-server start'},
" "\ https://github.com/palantir/python-language-server
" "\ 'python': #{command: 'pyls'},
" "\ https://github.com/vscode-langservers/vscode-css-languageserver-bin
" \ 'css':    #{command: 'css-languageserver --stdio'},
" "\ https://clang.llvm.org/extra/clangd/
" \ 'c':      #{command: 'clangd -log=error'},
" "\ https://github.com/sourcegraph/javascript-typescript-langserver
" \ 'javascript': #{command: 'javascript-typescript-stdio'},
" \ }

let g:lsc_enable_autocomplete = v:false      " Don't complete when typing.
let g:lsc_enable_diagnostics = v:false       " Don't lint code.
let g:lsc_reference_highlights = v:false     " Don't highlight references.
"let g:lsc_enable_incremental_sync = v:false  " Don't constantly send diffs to server.
let g:lsc_preview_split_direction = 'below'  " Show preview at bottom, rather than top.

"let g:lsc_auto_map = {'defaults': v:true, 'SignatureHelp': '<C-k>', 'GoToDefinitionSplit': ''}
let g:lsc_auto_map = {'defaults': v:true, 'GoToDefinitionSplit': ''}
augroup my-lsc
    au!
    au BufNewFile,BufReadPost *
        \  if has_key(get(g:, 'lsc_servers_by_filetype', {}), &filetype) && lsc#server#filetypeActive(&filetype)
        "\     Show function signature in insert mode too (I don't use digraphs).
        "\ \|     inoremap <buffer> <C-k> <C-o>:LSClientSignatureHelp<CR>
        "\     Open in tab, rather than split.
        \|     nnoremap <buffer> <C-w>]     :tab LSClientGoToDefinitionSplit<CR>
        \|     nnoremap <buffer> <C-w><C-]> :tab LSClientGoToDefinitionSplit<CR>
        \|     nnoremap <buffer> gd         :tab LSClientGoToDefinitionSplit<CR>
        \| endif

    " Resize to be as small as possible.
    au WinLeave __lsc_preview__ exe 'resize ' . min([&previewheight, line('$')])
    au User LSCShowPreview      exe 'resize ' . min([&previewheight, line('$')])
augroup end


"autocmd FileType go nnoremap <buffer> ;a :call <SID>alt()<CR>
" fun! s:alt() abort
"     let l:file = expand('%')
"     if empty(l:file)
"         return
"     elseif l:file[-8:] is# '_test.go'
"         let l:alt_file = l:file[:-9] . '.go'
"     elseif l:file[-3:] is# '.go'
"         let l:alt_file = l:file[:-4] . '_test.go'
"     else
"         return
"     endif
" 
"     let l:cmd = 'tabe'
"     if bufloaded(l:alt_file)
"         let l:cmd = 'sbuffer'
"     endif
"     exe printf(':%s %s', l:cmd, fnameescape(l:alt_file))
" endfun

fun! s:popper(popup_items) abort
    " TODO: don't do this
	let s:popup_items = a:popup_items
    let s:popup_map = {}
    for l:item in a:popup_items
        let s:popup_map[l:item[0]] = l:item[1]
    endfor

	call popup_create(map(a:popup_items, {_, v -> v[0]}), #{
        \ filter:     function('s:filter'),
        \ callback:   function('s:run_cmd'),
        \ mapping:    0,
        \ cursorline: 1,
        \ line:       'cursor+1',
        \ col:        'cursor',
	\ })
endfun

fun! s:filter(id, key) abort
  if a:key is# 'x' || a:key is# ''
    call popup_clear()
    return 1
  endif

  " No shortcut, pass to generic filter
  let l:action = get(s:popup_map, a:key, -1)
  if l:action is -1
    return popup_filter_menu(a:id, a:key)
  endif

  call popup_close(a:id, l:action)
  return 1
endfun

fun! s:run_cmd(id, cmd, ...) abort
  " Fixes some problems with the popup menu's buffer still being open when we
  " start doing various operations (wrong text, infinite recursion, etc.)
  " TODO(popup): I think this is a Vim bug? Or am I using it wrong? Need to look
  " deeper.
  call popup_clear()

  let l:cmd = a:cmd
  if type(l:cmd) is v:t_number
    let l:cmd = s:popup_items[a:cmd - 1]
  endif

  " :Command
  " !shell
  " expr
  let l:cmd = s:popup_map[l:cmd]
  exe l:cmd
endfun

nnoremap <silent> <Leader>l :call <SID>popper([
    \ ['actions',           ':LSClientFindCodeActions'],
    \ ['diag_line',         ':LSClientLineDiagnostics'],
    \ ['doc',               ':LSClientDocumentSymbol'],
    \ ['enable',            ':LSClientEnable'],
    \ ['goto',              ':LSClientGoToDefinition'],
    \ ['goto_split',        ':LSClientGoToDefinitionSplit'],
    \ ['hover',             ':LSClientShowHover'],
    \ ['impl',              ':LSClientFindImplementations'],
    \ ['ref',               ':LSClientFindReferences'],
    \ ['ref_next',          ':LSClientNextReference'],
    \ ['ref_prev',          ':LSClientPreviousReference'],
    \ ['rename',            ':LSClientRename'],
    \ ['restart',           ':LSClientRestartServer'],
    \ ['signature',         ':LSClientSignatureHelp'],
    \ ['workspace_symbol',  ':LSClientWorkspaceSymbol'],
    \ ['diag',              ':LSClientAllDiagnostics'],
    \ ['disable',           ':LSClientDisable'],
    \ ])<CR>

" vim:expandtab
