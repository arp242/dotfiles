" $dotid$

if has("gui_running")
	" Default width & height
	" TODO: Only do this on startup, not when reloading
	"set lines=55
	"set columns=120

	" Activate mouse
	set mouse=a

	" Use pop-up menu for right button
	set mousemodel=popup_setpos

	" Default clipboard is system clipboard
	set clipboard=unnamedplus

	" Also use the mouse for selection
	set selectmode=key,mouse

	" Set font
	if has('gui_gtk')
		set guifont=Dejavu\ Sans\ Mono\ 12
	else
		set guifont=Dejavu_Sans_Mono:h10
	endif

	" Don't blink the cursor
	set guicursor+=a:blinkon0
endif
