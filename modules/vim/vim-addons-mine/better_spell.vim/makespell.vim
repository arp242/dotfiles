" Estimated runtime memory use: 1246880 bytes
" Estimated runtime memory use: 1291410 bytes
"
" http://vi.stackexchange.com/q/118/51


" Call me with:
" vim -S makespell.vim
"
fun! MakeFile(lang, replace)
	execute "set spelllang=" . a:lang
	execute "set spell"
	execute "spelldump"
	call search("# file: ")
	let l:filename = split(getline("."), ":")[-1]
	let l:filename =  substitute(l:filename, '^\s*\|\s*$', '', 'g')

	" Make sure we load the original file from /usr/vim/ or /usr/local/vim
	if l:filename[0:len($HOME)-1] == $HOME
		execute "q"
		execute "set nospell"
		if rename(l:filename, l:filename . ".orig") != 0
			echoerr "Unable to rename file"
			return
		endif
		execute "set spell"
		execute "spelldump"
	endif

	let l:filename = split(l:filename, "/")[-1]
	while 1
		if search("'") == 0
			break
		endif

		if a:replace == 0
			normal! yy
			normal! p
		end
		execute "s/'/’/g"
	endwhile

	execute "w! /tmp/vim-spell-quotes"
	execute "mkspell! ~/.vim/spell/" . l:filename . " /tmp/vim-spell-quotes"

	call delete("/tmp/vim-spell-quotes")
	execute "q"
	echo "File ~/vim/spell/" . l:filename . " written"
endfun

call MakeFile("en_gb", 1)
