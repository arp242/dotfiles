" PLUGIN.vim
" 
" http://code.arp242.net/PLUGIN.vim
"
" See the bottom of this file for copyright & license information.
"

"##########################################################
" Initialize some stuff
scriptencoding utf-8
if exists('g:loaded_PLUGIN') | finish | endif
let g:loaded_PLUGIN = 1
let s:save_cpo = &cpo
set cpo&vim


"##########################################################
" Options
if !exists('g:PLUGIN')
	let g:PLUGIN = 0
endif

"##########################################################
" Commands


"##########################################################
" Mappings
nnoremap <silent> <Plug>(PLUGIN_DASH-example) :call PLUGIN#example()<CR>

if !exists('g:PLUGIN_no_map') || empty(g:PLUGIN_no_map)
	"nmap n <Plug>(PLUGIN_DASH-example)
endif


"##########################################################
" Functions

fun! PLUGIN#example() abort
endfun


let &cpo = s:save_cpo
unlet s:save_cpo


" The MIT License (MIT)
"
" Copyright © 2015 Martin Tournoij
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

