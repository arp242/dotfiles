" Open multiple tabs at once
fun! OpenMultipleTabs(pattern_list, ...)
	let l:expr = a:0 > 0 ? a:1 : ''
	for p in a:pattern_list
		for c in glob(l:p, 0, 1)
			execute 'tabedit ' . l:c
			if l:expr
				eval(l:expr)
			endif
		endfor
	endfor
endfun

command! -bar -bang -nargs=+ -complete=file Tabedit call OpenMultipleTabs([<f-args>])

"cabbr tabe Tabe
"cnoremap tabe<CR> call OpenMultipleTabs(split(getcmdline(), ' '))
