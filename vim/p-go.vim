" Settings for Vim-go

let g:go_fmt_autosave = 0                " We use ALE.
let g:go_list_type = 'locationlist'      " Always use location list.
let g:go_highlight_build_constraints = 1 " Highlight // +build tag.
let g:go_test_show_name = 1              " Add test name in :GoTest.
let g:go_def_mapping_enabled = 0         " Don't map GoDef related stuff (we do this ourselves later).
let g:go_gocode_unimported_packages = 1  " Include suggestions for unimported packages.
let g:go_doc_max_height = 10             " Don't make the godoc window too high.
let g:go_addtags_transform = "camelcase" " Use camelCase for tags.
let g:go_alternate_mode = 'tabe'         " Use :tabedit for :GoAlternate
let g:go_fold_enable = ['import', 'package_comment'] " Fold import blocks and package comments, but nothing else.

" TODO: This will make the cursor go to the {quickfix,loc}list :-/ Even worse!
"let g:go_jump_to_error = 0               " Don't move my cursor!

augroup my_go_settings
	autocmd!

	" Because I use ALE these commands are useless to me.
	autocmd FileType go
				\  delc GoErrCheck | delc GoLint | delc GoVet
				\| delc GoFmt | delc GoImports | delc GoFmtAutoSaveToggle
				\| delc GoMetaLinterAutoSaveToggle | delc GoMetaLinter
				\| delc GoAsmFmtAutoSaveToggle

    " I simply never use these.
	autocmd FileType go
				\  delc GoAutoTypeInfoToggle | delc GoBuildTags | delc GoSameIdsAutoToggle | delc GoTemplateAutoCreateToggle | delc GoSameIdsToggle
				\| delc GoReportGitHubIssue
				\| delc GoDecls | delc GoDeclsDir
				\| silent! delc GoInstallBinaries | silent! delc GoUpdateBinaries

	" Enable syntax-based folding and close all folds.
	autocmd FileType go setlocal foldmethod=syntax | normal! zM

	" Shortcut to write and install.
	autocmd FileType go nmap MM :wa<CR><Plug>(go-install)
	autocmd FileType go nmap TT :wa<CR><Plug>(go-test)

	" Need to map these defaults because go_def_mapping_enabled is off.
	autocmd FileType go nnoremap <buffer> <silent> <C-]> :GoDef<CR>
	autocmd FileType go nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<CR>

	" Open gd in a new tab.
	autocmd FileType go nmap gd <Plug>(go-def-tab)
	autocmd FileType go nnoremap <Leader>a :<C-u>call go#alternate#Switch(1, '')<CR>

	" Set makeprg to go install instead of go build -i.
	autocmd FileType go let &l:makeprg = 'go install'

	" Correct filetype and makeprg for Go templates.
	autocmd BufRead /home/martin/work/*.html
		\ setl ft=gohtmltmpl makeprg=go\ install

	" Set makeprg to go install instead of go build.
	autocmd FileType go
		\  if expand('%:p') =~# '^/home/martin/work/src/github.com/teamwork/desk/'
		\|   let &l:makeprg = 'go install github.com/teamwork/desk/cmd/desk'
		\| elseif expand('%:p') =~# '^/home/martin/work/src/github.com/teamwork/deskimporter/'
		\|   let &l:makeprg = 'go install github.com/teamwork/deskimporter/cmd/deskimporter'
		\| else
		\|   let &l:makeprg = 'go install'
		\| endif

	" Make sure guru scope is set correct.
	autocmd BufRead /home/martin/work/src/*.go
				\  let s:tmp = matchlist(expand('%:p'),
					\ '/home/martin/work/src/\(github.com/teamwork/[^/]\+\)')
				\| if len(s:tmp) > 1 | exe 'silent :GoGuruScope ' . s:tmp[1] | endif
				\| unlet s:tmp

	" Set build tags.
	autocmd BufRead /home/martin/work/src/github.com/teamwork/desk/*.go
				\ let g:go_build_tags = 'testdb'

	" Use "botright new" instead of "new"
	"autocmd FileType go
	" \ command! -nargs=* -range -complete=customlist,go#package#Complete GoDoc
	"	\ call go#doc#Open('botright new', 'split', <f-args>)

	"" Don't focus new window with K
	"" TODO: make it work from completion too
	"autocmd FileType go nnoremap <buffer> <silent> K :call <SID>k()<CR>
	"autocmd FileType go inoremap <buffer> <silent> <C-k> <C-o>:call <SID>k()<CR>
augroup end



" Automatically create start of GoDoc comment.
" TODO: Doesn't work too well yet... Should probably make a "real" Go tool for
" this.
fun! s:comment()
	" Only do this for new lines.
	if getline('.') != '' && getline('.') != "\t" | return '//' | endif

	let l:next = getline(line('.') + 1)

	try
		let l:word = ''
		if l:next[:3] ==# 'var ' || l:next[:4] ==# 'type ' || l:next[:4] ==# 'const '
			let l:word = split(l:next, ' ')[1]
		elseif l:next[:4] ==# 'func '
			" Receiver
			if l:next[5] == '('
				let l:word = split(split(l:next, ' ')[3], '(')[0]
			else
				let l:word = split(split(l:next, ' ')[1], '(')[0]
			endif
		" var ( .. ) and const ( .. ) blocks.
		"elseif l:next[0] == "\t"
		"	let l:word = split(l:next, ' ')[0][1:]
		"endif

		if l:word != ""
			return '// ' . l:word
		else
			return '//'
		endif
	catch
		return '//'
	endtry
endfun
"inoremap <expr> // <SID>comment()


" Toggle between "single-line" and "normal" if checks:
"
"   err := e()
"   if err != nil {
"
" and:
"
"   if err := e(); err != nil {
"
" TODO: See if we can integrate this in https://github.com/AndrewRadev/splitjoin.vim
" TODO: Check if we can integrate this in expanderr.
fun! s:switch_if()
	let l:line = getline('.')
	if match(l:line, "if ") == -1
		" Try line below current one too.
		let l:line = getline(line('.') + 1)

		if match(l:line, "if ") == -1
			echohl Error | echom "No 'if' in current line" | echohl Normal
			return
		endif

		normal! j
	endif

	let l:line = substitute(l:line, "^\\s*", "", "")
	let l:indent = repeat("\t", indent('.') / 4)

	" Convert "if .. {" to "if ..; err != nil {".
	if match(l:line, ";") == -1
		let l:prev_line = substitute(getline(line('.') - 1), "^\\s*", "", "")
		execute ':' . (line('.') - 1) . 'd _'
		call setline('.', printf('%sif %s; err != nil {', l:indent, l:prev_line))
	" Convert "if ..; err != nil {" to "if .. {".
	else
		let [l:prev_line, l:line] = split(l:line, "; ")
		let l:prev_line = substitute(l:prev_line, "^\\s*", "", "")[3:]
		call setline('.', printf('%sif %s', l:indent, l:line))
		call append(line('.') - 1, printf("%s%s", l:indent, l:prev_line))
	endif
endfun
nnoremap <Leader>e :call <SID>switch_if()<CR>

" Wrap Go error; cursor can be anywher on the line, but must be in "return".
"   return err
"   return errors.Wrap(err, "")
"
" TODO: Again, write a real tool :-)
fun! s:wrap_err()
	" Start of line
	normal! ^

	" Skip past return
	normal! w

	" Insert
	exe "normal! ierrors.Wrap(\<Esc>"

	" Skip past err
	normal! $

	" Insert, leaving cursor on closing )
	exe "normal! a)\<Esc>"
	exe "normal! i, \"\"\<C-o>h"
endfun
nnoremap <Leader>w :call <SID>wrap_err()<CR>


" TODO: Pressing K while window is active should close it (and do nothing else)
" TODO: Running this a second time makes window go at top?!
fun! s:k() abort
	silent! call go#doc#Open('botright new', 'split')
	"silent! :GoDoc

	" On error save the cursor position and try to find docs for the function
	" declaration.
	"if go#util#ShellError()
		let l:pos = getpos('.')
		try
			normal! ^f(h
			"silent! call go#doc#Open('botright new', 'split')
			silent! :GoDoc
			if go#util#ShellError()
				call go#util#EchoError("No docs found. Sorry :-(")
				return
			endif
		finally
			call setpos('.', l:pos)
		endtry
	"endif

	" godoc adds an "import" line at the top which is pretty redundant IMHO;
	" remove if present.
	setl modifiable
	:0g/^import /d
	:%s/\%^\n\+//
	:%s/\n\+\%$//
	setl nomodifiable
	:1

	" Set statusline to something that makes more sense.
	setlocal stl=%f\ %P

	" Focus previous window.
	exe "normal! \<C-w>w"
endfun



" For testing/development of vim-go's syntax file.
fun! s:all_syntax()
	let g:go_highlight_array_whitespace_error = 1
	let g:go_highlight_chan_whitespace_error = 1
	let g:go_highlight_extra_types = 1
	let g:go_highlight_space_tab_error = 1
	let g:go_highlight_trailing_whitespace_error = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_methods = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_types = 1
	let g:go_highlight_build_constraints = 1
	let g:go_highlight_generate_tags = 1
	let g:go_highlight_variable_declarations = 1
	let g:go_highlight_variable_assignments = 1
    let g:go_highlight_function_arguments = 1
	"let g:go_fold_enable = ['import', 'package_comment', 'block', 'varconst', 'comment']
endfun
"call s:all_syntax()

function! s:create_go_doc_comment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I// \<Esc>$"
endfunction
nnoremap <leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>
