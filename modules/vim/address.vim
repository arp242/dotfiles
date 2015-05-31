" TODO:
" - Add addresses from external script
" - Make AddAddress smarter, eg. when selecting "Martin <martin@arp242.net>" it
"   should be smart enough to parse it
" - Source vim script as addresses, and load addresses from YAML, JSON, XML?

let g:address_file = '/home/martin/.mutt/address'

command! AddAddress :call AddAddress()

" Only set completefunc for emails
augroup address
	autocmd!
	autocmd! FileType mail setlocal completefunc=CompleteEmail
augroup end

let g:addresses = []
fun! ReadAddressFile()
	return map(readfile(g:address_file), 'split(v:val, "")')
endfun


" Complete function for addresses; we match the name & address
fun! CompleteEmail(findstart, base)
	" Locate the start of the word
	if a:findstart
		let l:line = getline('.')
		let l:start = col('.') - 1
		while l:start > 0 && l:line[l:start - 1] =~ '\a'
			let l:start -= 1
		endwhile
		return l:start
	end

	" Load database, if not initialized
	if g:addresses == [] | let g:addresses = ReadAddressFile() | endif

	" Find matches
	let l:res = []
	for m in g:addresses
		if l:m[0] !~? '^' . a:base && l:m[1] !~? '^' . a:base | continue | endif

		call add(l:res, {
			\ 'icase': 1,
			\ 'word': l:m[0] . ' <' . l:m[1] . '>, ',
			\ 'abbr': l:m[0],
			\ 'menu': l:m[1],
			\ 'info': len(l:m) > 2 ? join(l:m[2:], "\n") : '',
		\ })
	endfor

	return l:res
endfun


" Add a new address
fun! AddAddress()
	let l:word = expand('<cWORD>')
	let l:default_email = ''

	" The current word looks like an email address
	if l:word =~ '@'
		let l:default_email = substitute(l:word, '^<\(.*\)>$', '\1', '')
	endif

	if l:default_email != ''
		let l:email = input('Email (enter for ' . l:default_email . '): ')
		if l:email == '' | let l:email = l:default_email | endif
	else
		let l:email = ''
		while 1
			let l:email = input('Email: ')
			if l:email =~ '@'
				break
			else
				echo "\nThat doesn't look like a valid address. Try again, or hit ^C to abort."
			endif
		endwhile
	endif

	let l:name = input('Name (optional): ')

	call writefile([l:email . '' . l:name], g:address_file, 'a')
	let g:addresses = ReadAddressFile()
endfun
