if !has('gui_running')
    finish
endif

" Don't iconfy on <C-z>
noremap <C-z> <NOP>

set mousemodel=popup_setpos            " Use pop-up menu for right button.
set selectmode=key,mouse               " Also use the mouse for selection.
set clipboard=unnamedplus              " Default clipboard is system clipboard.
set guicursor+=a:blinkon0              " Don't blink the cursor
set guioptions=aiM                     " Remove all the GUI cruft and make gVim look and behave like Vim
                                       " a: copy-on-select
                                       " i: Use icon
                                       " M: No menu

if has('gui_gtk')                      " Set font
    set guifont=Dejavu\ Sans\ Mono\ 16

    " TODO: make it look the same as terminal, which has:
    "static char *font = "DejaVu Sans Mono:pixelsize=22:antialias=true:autohint=true";
elseif has('gui_win32')
    set guifont=Dejavu_Sans_Mono:h10
endif


" vim:expandtab

