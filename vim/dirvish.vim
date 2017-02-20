" $dotid$

" Make paths in the Dirvish buffer relative to getcwd().
let g:dirvish_relative_paths = 1

fun! s:dirvish() abort
	" U for up
	nnoremap <buffer> <silent> U :Dirvish %:h:h<CR>

	" I don't like this. I use q to close :reg, :ls, etc.
	silent! unmap <buffer> q

	" Add tab mappings
	nnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>
	xnoremap <buffer> t :call dirvish#open('tabedit', 0)<CR>

	" Launch shell in cwd
	nnoremap <buffer> <C-t> :lcd %<CR>:silent exec '!' . (has('gui_running') ? 'xterm -e ' : '') . $SHELL<CR>:lcd<CR><C-l>

	" Hide dotfiles/wildignore
	nnoremap <nowait> <buffer> <silent> gw :call ToggleFilter('dirvish_wildignore', '/\v\.(png<Bar>jpg<Bar>jpeg<Bar>pyc)$/')<CR>
	nnoremap <nowait> <buffer> <silent> gh :call ToggleFilter('dirvish_dotfiles', '@\v/\.[^\/]+/?$@')<CR>

	normal gh
endfun

fun! ToggleFilter(varname, pattern) abort
    let l:line = line('.')

    " No buffer variable, cut the pattern to that
    if len(getbufvar('%', a:varname)) == 0
        let l:h = @h
        let @h = ''
        silent! execute ':g' . a:pattern . 'y H'
		if @h == ''
			return
		endif
        silent g//d _
        call setbufvar('%', a:varname, split(@h, '\n'))
        let @h = l:h
        execute ':' . string(max([0, l:line - len(getbufvar('%', a:varname))]))
    " buffer variable exists: restore
    else
        call append(0, getbufvar('%', a:varname))
        execute ':' . (l:line + len(getbufvar('%', a:varname)))
        execute 'unlet b:' . a:varname
    endif
endfun

augroup dirvish_local
	autocmd!
	autocmd Filetype dirvish :call s:dirvish()
augroup end
