" Helpline

" http://www.vim.org/scripts/script.php?script_id=3383
" http://www.vim.org/scripts/script.php?script_id=8
" http://www.vim.org/scripts/script.php?script_id=296
" https://github.com/itchyny/lightline.vim

set statusline=
let &stl .= '%<%f'                " Filename, truncate right
let &stl .= ' %h%m%r'             " [Help] [modified] [read-only]
let &stl .= '%='                  " Right-align from here on

"let &stl = ' %2*FUNCTION%0*'
let &stl .= ' %1*%{&ft}%0*'       " Show filetype
"let &stl .= ' %1*BRANCH%0*'
let &stl .= ' [line %l of %L]'    " current line, total lines
let &stl .= ' [col %c]'           " column
let &stl .= ' [0x%B]'             " Byte value under cursor

"let &stl .= '%{system("date +%H:%m:%S")[:-2]}'

highlight User1 ctermbg=0 ctermfg=245 cterm=bold
autocmd ColorScheme *
	\ highlight User1 ctermbg=0 ctermfg=245 cterm=bold

let g:original_statusline = &statusline

" Branch name
" function name
" class name
" function or class name

"augroup helpline
"	autocmd!
"	autocmd BufNewFile,BufReadPost,BufEnter,FileType,FileChangedShellPost,ShellCmdPost,ShellFilterPost * call ChainStatusline()
"	autocmd InsertEnter,InsertLeave,CursorHold,CursorHoldI * call ChainStatusline()
"augroup end


fun! ChainStatusline()
	let l:statusline = g:original_statusline

	if match(g:original_statusline, 'FUNCTION') > -1
		let l:statusline = StatuslineFunction(l:statusline)
	endif
	
	if match(g:original_statusline, 'BRANCH') > -1
		let l:statusline = StatuslineBranch(l:statusline)
	endif

	let &statusline = l:statusline
endfun


fun! PHPFunctionInStatusLine(statusline)
	let l:save_cursor = getpos('.')

	call search('\s\=function\s', 'bc')
	let l:line = substitute(getline('.'), '^\s*', '', '')
	let l:line = substitute(l:line, ' \={ \=', '', '')
	let l:statusline = substitute(a:statusline, 'FUNCTION', ' ' . l:line . ' ', '')

	call setpos('.', l:save_cursor)
	return l:statusline
endfun


fun! RubyFunctionInStatusLine(statusline)
	let l:save_cursor = getpos('.')

	call search('\s\=\(def\|class\|module\)\s', 'bc')
	let l:line = substitute(getline('.'), '^\s*', '', '')
	let l:line = substitute(l:line, ' \={ \=', '', '')
	let l:statusline = substitute(a:statusline, 'FUNCTION', ' ' . l:line . ' ', '')

	call setpos('.', l:save_cursor)
	return l:statusline
endfun


fun! StatuslineFunction(statusline)
	if &filetype == 'ruby'
		return RubyFunctionInStatusLine(a:statusline)
	elseif &filetype == 'php'
		return PHPFunctionInStatusLine(a:statusline)
	else
		return substitute(a:statusline, 'FUNCTION', '', '')
	endif
endfun


fun! StatuslineBranch(statusline)
	let l:branch = system('git rev-parse --abbrev-ref HEAD')[:-2]
	if v:shell_error > 0
		return  substitute(a:statusline, 'BRANCH', '', '')
	else
		return substitute(a:statusline, 'BRANCH', l:branch, '')
	endif
endfun
