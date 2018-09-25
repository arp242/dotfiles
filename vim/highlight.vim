" Set up some highlight groups.

fun! s:hi()
	" Works better
	hi DiffText ctermbg=lightred

	" Not so dark.
	hi SignColumn ctermbg=254

	" Same as CursorColumn
	hi CursorLine ctermbg=7 cterm=NONE

	hi StatusLineGray term=bold,reverse cterm=bold,reverse gui=bold,reverse ctermbg=254

	hi ErrorSTL term=bold,reverse cterm=bold,reverse gui=bold,reverse
				\ ctermfg=NONE guifg=NONE

	" Not so bright
	"hi LineNr ctermfg=253
	"hi CursorLineNr ctermfg=253
	"hi qfLineNr ctermfg=4
	"MatchParen     xxx term=reverse ctermbg=14 guibg=Cyan
endfun

augroup my_highlight
	autocmd!
	autocmd Colorscheme * call s:hi()
augroup end
call s:hi()
