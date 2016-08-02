" brace_wars.vim: convert between different brace styles
"
" http://code.arp242.net/brace_wars.vim
"
" See the bottom of this file for copyright & license information.
"


"##########################################################
" Initialize some stuff
scriptencoding utf-8
if exists('g:loaded_brace_wars') | finish | endif
let g:loaded_brace_wars = 1
let s:save_cpo = &cpo
set cpo&vim


"##########################################################
" Commands

" -range?
" -count?
command! -nargs=+ Bracewars :call brace_wars#fight(<q-args>)


fun! brace_wars#fight(style, filetype) abort
	if !exists('*s:' . a:style)
		echoerr "This is not the style you are looking for (it doesn't exist!)"
		return
	endif

    let l:save = winsaveview()
	call eval('s:' . a:style . '()')
	call winrestview(l:save)
endfun


fun s:function()
	if &ft == 'c'
		return ''
	elseif &ft == 'cpp'
		return ''
	elseif &ft == 'java'
		return ''
	elseif &ft == 'php'
		return 'function'
	elseif &ft == 'javascript'
		return 'function'
	elseif &ft == 'perl'
		return ''
	endif
endfun


fun s:keywords()
	if &ft == 'c'
		return ['if|for|while', 'else']
	elseif &ft == 'cpp'
		return ['if|for|while', 'else']
	elseif &ft == 'java'
		return ['if|for|while', 'else']
	elseif &ft == 'php'
		return ['if|for|while|try|foreach', 'else|catch']
	elseif &ft == 'javascript'
		return ['if|for|while|try', 'else|catch']
	elseif &ft == 'perl'
		return ['if|for', 'else']
	endif
endfun


" Stroustrup
" 
" int main()
" {
"     if (true) {
"         foo()
"     }
"     else {
"         bar()
"     }
" }
function s:stroustrup()
    silent! %s/\v(\s*)}\s*(else|catch)/\1}\r\1\2/e
endfun


" K&R
"
" int main()
" {
"     if (true) {
"         foo()
"     } else {
"         bar()
"     }
" }
fun! s:kr()
    silent! %s/\v}\_.(\s*)(else|catch)/} \2/e
endfun


" Allman
"
" int main()
" {
"     if (true)
"     {
"         foo();
"     }
"     else
"     {
"         bar();
"     }
"}
fun! s:allman()
endfun


" GNU
"
" int main()
" {
"     if (true)
"         {
"             foo();
"         }
"     else
"         {
"             bar();
"         }
" }
fun! s:gnu()
endfun


let &cpo = s:save_cpo
unlet s:save_cpo


" The MIT License (MIT)
"
" Copyright © 2015-2016 Martin Tournoij
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to
" deal in the Software without restriction, including without limitation the
" rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
" sell copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" The software is provided "as is", without warranty of any kind, express or
" implied, including but not limited to the warranties of merchantability,
" fitness for a particular purpose and noninfringement. In no event shall the
" authors or copyright holders be liable for any claim, damages or other
" liability, whether in an action of contract, tort or otherwise, arising
" from, out of or in connection with the software or the use or other dealings
" in the software.
