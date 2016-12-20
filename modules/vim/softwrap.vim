" $dotid$
"
" Very unobtrusively highlight column 81 to indicate that we may have to wrap
" stuff − this is a "soft wrap".
" Column 121 is highlighted a bit more obvious, as this is really getting too long!
"
" This is a less obtrusive way of doing "set colorcolumn" (which is just
" distracting and annoying).
fun! s:color()
	highlight SoftWrap cterm=underline gui=underline
	highlight HardWrap ctermbg=225 guibg=lightyellow
endfun
call s:color()
augroup softwrap
	autocmd!
	autocmd Colorscheme * call s:color()

	" I don't know why this needs to be in this autocmd, but sometimes it won't
	" work if it's not...
	autocmd BufReadPost,BufNew *
		\  call matchadd('SoftWrap', '\%82v')
		\| call matchadd('HardWrap', '\%122v')
augroup end
