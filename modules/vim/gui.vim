" $dotid$

if has("gui_running")
	" Default width & height; autocmd to prevent resize when re-loading vimrc
	autocmd VimEnter * set lines=55 columns=120

	" Use pop-up menu for right button
	set mousemodel=popup_setpos

	" Also use the mouse for selection
	set selectmode=key,mouse

	" Default clipboard is system clipboard
	set clipboard=unnamedplus

	" Set font
	if has('gui_gtk')
		set guifont=Dejavu\ Sans\ Mono\ 12
	else
		set guifont=Dejavu_Sans_Mono:h10
	endif

	" Don't blink the cursor
	set guicursor+=a:blinkon0

	" Remove all the GUI cruft and make gVim look and behave like Vim
	" a: copy-on-select
	" i: Use icon
	" M: No menu
	set guioptions=aiM
endif
