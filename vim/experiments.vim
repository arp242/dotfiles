" $dotid$

" Show line number relative to the cursor
"set relativenumber
"set number

" Don't reserve any space for the number column
"set numberwidth=1

" Not so bright
hi LineNr ctermfg=253
hi CursorLineNr ctermfg=253
hi qfLineNr ctermfg=4
"hi SignColumn ctermbg=grey

" Works better
hi DiffText ctermbg=lightred



augroup filetypes
    autocmd!

    autocmd FileType cpp call s:cpp()
augroup end

" Set up ft=cpp
fun! s:cpp()
	let b:original_textwidth = 6
    augroup ft_cpp
        autocmd!
        autocmd CursorMoved,CursorMovedI <buffer>
            \  if index(["cCommentL", "cComment"], synIDattr(synID(line('.'), col('.'), 1), 'name')) >= 0
            \|     setlocal textwidth=0
            \| else
            \|     let &l:textwidth = b:original_textwidth
            \| endif
    augroup end
endfun

fun! FindSyntax(name) abort
	" Try to find this syntax item. Unfortunatly this can't really be queried
	" with a function, so this is a bit ugly.
	let l:syn_list = execute(':syntax list ' . a:name)
	let l:pattern = ''
	for l:line in split(l:syn_list, '\n')
		if l:line[:len(a:name)-1] == a:name
			let l:pattern = l:line
			break
		endif
	endfor
	if l:pattern == ''
		echoerr 'unable to find syntax pattern for ' . a:name
	endif

	" Find pattern. This is somewhat limited and only works for :syn match ..
	let l:pattern = substitute(l:pattern, a:name . '\s\+xxx match /\(.\+\)/', '\1', 0)[:-3]

	echo l:pattern . '|'

	" Jump to next instance of this pattern
	call search(l:pattern)	
endfun

" Next section
nnoremap <Leader>ns :call FindSyntax('manSectionHeading')<CR>
" Next option
nnoremap <Leader>no :call FindSyntax('manOptionDesc')<CR>
