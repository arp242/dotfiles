if !has('gui_running')
	finish
endif

" Don't iconfy on <C-z>
noremap <C-z> <NOP>

" Default width and height; autocmd to prevent resize when reloading vimrc.
augroup gui
	au!
	au VimEnter * set lines=55 columns=120
augroup end

set mousemodel=popup_setpos            " Use pop-up menu for right button
set selectmode=key,mouse               " Also use the mouse for selection
set clipboard=unnamedplus              " Default clipboard is system clipboard
set guicursor+=a:blinkon0              " Don't blink the cursor
set guioptions=aiM                     " Remove all the GUI cruft and make gVim look and behave like Vim
                                       " a: copy-on-select
                                       " i: Use icon
                                       " M: No menu
if has('gui_gtk')                      " Set font
	set guifont=Dejavu\ Sans\ Mono\ 12
else
	set guifont=Dejavu_Sans_Mono:h10
endif
