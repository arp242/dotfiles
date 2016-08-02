fun! s:clear_old(dir, age)
	" Method one: find. This is the easiest and fastest way.
	
	" For Windows we can use the VimScript backup.
endfun


fun! s:clear_backup(age)
	return s:clear_old(&backupdir, 365)
endfun

fun! s:clear_undo()
	return s:clear_old(&undodir, 60)
endfun

fun! s:clear_swap()
	return s:clear_old(&dir, 3650)
endfun
