" $dotid$

let g:go_fmt_experimental = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_fold_blocks = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 0

let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_jump_to_error = 0
let g:go_gocode_unimported_packages = 1

let g:go_list_type = "locationlist"
let g:go_doc_max_height = 10

"let g:go_highlight_types = 1
let g:go_fold_enable = ['import']

augroup my_go_settings
	autocmd!

	"autocmd FileType go 
	"	\  setlocal foldmethod=syntax
	"	\| normal! zM

	" Open gd in a new tab with gd
	autocmd FileType go nmap gd <Plug>(go-def-tab)
	" Need to map these defaults because go_def_mapping_enabled is off.
	autocmd FileType go
		\ nnoremap <buffer> <silent> <C-]> :GoDef<CR>
		\| nnoremap <buffer> <silent> <C-t> :<C-U>call go#def#StackPop(v:count1)<CR>

	" Don't focus new window with K
	autocmd FileType go
		\ nnoremap <buffer> K :GoDoc<CR>:setl stl=%f\ %P<CR>

	" Make sure the correct GOPATH is used; vim-go doesn't deal with two GOPATHs
	" very well.
	autocmd BufRead /home/martin/work/*.go 
		\  :let g:go_guru_scope = ['github.com/teamwork/desk']
		\| :silent :GoPath /home/martin/work

	" Set makeprg to go install instead of go build.
	autocmd FileType go setlocal makeprg=go\ install

	" Build/Test on save.
	"autocmd BufWritePost *.go :GoBuild
	"autocmd BufWritePost *_test.go :GoTest
augroup end

" Automatically create start of GoDoc comment.
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


" create a go doc comment based on the word under the cursor
fun! s:create_go_doc_comment()
  normal! "zyiw
  put! z
  execute ":normal! I// \<Esc>$"
endfun
"nnoremap <Leader>ui :<C-u>call <SID>create_go_doc_comment()<CR>


" Toggle between "single-line" and "normal" if checks:
"
"   err := e()
"   if err != nil {
"
" and:
"
"   if err := e(); err != nil {
fun! s:switch_if()
	let l:indent = repeat("\t", indent('.') / 4)
	let l:line = substitute(getline('.'), "^\\s*", "", "")

	if match(l:line, "if ") == -1
		echohl Error | echom "No 'if' in current line" | echohl Normal
		return
	endif

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
