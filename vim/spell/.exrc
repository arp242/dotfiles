if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
imap <silent> <Home> <Home>
inoremap <expr> <Up> pumvisible() ? "\"  : "\<Up>"
inoremap <expr> <Down> pumvisible() ? "\"  : "\<Down>"
inoremap <F12> :set cursorline!
inoremap <F11> :set cursorcolumn!
inoremap <F10> :set list!
inoremap <F9> :set shiftround!
inoremap <F1> :helpclose
nnoremap <silent>  :nohlsearch:setl nolist nospell:diffupdate
nmap  <Plug>(undofile-warn-redo)
nmap - <Plug>(dirvish_up)
vnoremap < <gv
vnoremap > >gv
nnoremap MM :wa:make
nnoremap <silent> OO :silent wincmd o
noremap Q gq
nnoremap RR "_ddP
noremap \P "+p
noremap \Y "+y
noremap \p "*p
noremap \y "*y
nnoremap \sd :set spelllang=de_de
nnoremap \su :set spelllang=en_us
nnoremap \se :set spelllang=en_gb
nnoremap \sn :set spelllang=nl
nnoremap \ss :set spell!:set spell?
nnoremap \r :source $MYVIMRC
xmap gx <Plug>(xdg-open-x)
nmap gx <Plug>(xdg-open-n)
vnoremap gF gF
nnoremap gF gF
vnoremap gf gf
nnoremap gf gf
nnoremap j gj
nnoremap k gk
nnoremap q: :q
nmap u <Plug>(undofile-warn-undo)
xnoremap <silent> <Plug>(xdg-open-x) :call xdg_open#open(1)
nnoremap <silent> <Plug>(xdg-open-n) :call xdg_open#open(0)
nnoremap <silent> <Plug>(qf_newer) : call qf#history#Newer()
nnoremap <silent> <Plug>(qf_older) : call qf#history#Older()
nnoremap <silent> <expr> <Plug>(qf_qf_switch) &filetype ==# 'qf' ? 'p' : 'b'
nnoremap <silent> <Plug>(qf_loc_toggle_stay) : call qf#toggle#ToggleLocWindow(1)
nnoremap <silent> <Plug>(qf_loc_toggle) : call qf#toggle#ToggleLocWindow(0)
nnoremap <silent> <Plug>(qf_qf_toggle_stay) : call qf#toggle#ToggleQfWindow(1)
nnoremap <silent> <Plug>(qf_qf_toggle) : call qf#toggle#ToggleQfWindow(0)
nnoremap <silent> <Plug>(qf_loc_next) : call qf#wrap#WrapCommand('down', 'l')
nnoremap <silent> <Plug>(qf_loc_previous) : call qf#wrap#WrapCommand('up', 'l')
nnoremap <silent> <Plug>(qf_qf_next) : call qf#wrap#WrapCommand('down', 'c')
nnoremap <silent> <Plug>(qf_qf_previous) : call qf#wrap#WrapCommand('up', 'c')
nmap <silent> <expr> <Plug>QfSwitch &filetype ==# 'qf' ? 'p' : 'b'
nmap <silent> <Plug>QfLtoggle <Plug>(qf_loc_toggle)
nmap <silent> <Plug>QfCtoggle <Plug>(qf_qf_toggle)
nmap <silent> <Plug>QfLnext <Plug>(qf_loc_next)
nmap <silent> <Plug>QfLprevious <Plug>(qf_loc_previous)
nmap <silent> <Plug>QfCnext <Plug>(qf_qf_next)
nmap <silent> <Plug>QfCprevious <Plug>(qf_qf_previous)
nnoremap <silent> <Plug>(dirvish_vsplit_up) :exe 'vsplit +Dirvish\ %:p'.repeat(':h',v:count1)
nnoremap <silent> <Plug>(dirvish_split_up) :exe 'split +Dirvish\ %:p'.repeat(':h',v:count1)
nnoremap <silent> <Plug>(dirvish_up) :exe 'Dirvish %:p'.repeat(':h',v:count1)
nnoremap <silent> <Plug>(undofile-warn-redo) :call undofile_warn#redo()
nnoremap <silent> <expr> <Plug>(undofile-warn-undo) undofile_warn#undo()
noremap <expr> <Home> col('.') is# match(getline('.'), '\S') + 1 ? '0' : '^'
nnoremap <Down> gj
nnoremap <Up> gk
nnoremap <F12> :set cursorline!:set cursorline?
nnoremap <F11> :set cursorcolumn!:set cursorcolumn?
nnoremap <F10> :set list!:set list?
nnoremap <F9> :set shiftround!:set shiftround?
nnoremap <F1> :helpclose
cnoremap  <Home>
inoremap  :LSClientSignatureHelp
iabbr 1= !=
iabbr ;= :=
cabbr ta tabe
cabbr tane tabe
iabbr taht that
iabbr Teh The
iabbr teh the
cabbr Help help
cabbr Set set
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=indent,eol,start
set backup
set backupdir=~/.vim/tmp/backup
set backupext=.bak
set clipboard=
set completeopt=longest,menuone
set directory=~/.vim/tmp/swap
set display=lastline,uhex
set fileencodings=ucs-bom,utf-8,default,latin1
set formatoptions=tjncroql
set formatlistpat=^\\s*\\(\\d\\|-\\)\\+[\\]:.)}\\t\ ]\\s*
set gdefault
set helplang=en
set history=500
set hlsearch
set ignorecase
set incsearch
set infercase
set nojoinspaces
set langmenu=en
set laststatus=2
set listchars=tab:!·,trail:·
set matchpairs=(:),{:},[:],<:>
set nrformats=bin,hex
set paragraphs=
set pumheight=10
set ruler
set rulerformat=%l/%L\ %c\ 0x%B
set runtimepath=~/.vim,~/.vim/pack/plugins/start/xdg_open.vim,~/.vim/pack/plugins/start/vim-vimhelplint,~/.vim/pack/plugins/start/vim-qf,~/.vim/pack/plugins/start/vim-lsc,~/.vim/pack/plugins/start/vim-editorconfig,~/.vim/pack/plugins/start/vim-dirvish,~/.vim/pack/plugins/start/undofile_warn.vim,~/.vim/pack/plugins/start/typescript-vim,~/.vim/pack/plugins/start/tabular,~/.vim/pack/plugins/start/softwrap.vim,~/.vim/pack/plugins/start/scomplete.vim,~/.vim/pack/plugins/start/helplink.vim,~/.vim/pack/plugins/start/gopher.vim,~/.vim/pack/plugins/start/globedit.vim,~/.vim/pack/plugins/start/default2.vim,~/.vim/pack/plugins/start/auto_mkdir2.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim81,~/.vim/pack/plugins/start/vim-qf/after,~/.vim/pack/plugins/start/vim-lsc/after,~/.vim/pack/plugins/start/tabular/after,/usr/share/vim/vimfiles/after,~/.vim/after
set scrolloff=5
set shiftround
set shiftwidth=0
set showcmd
set showtabline=2
set smartcase
set smarttab
set softtabstop=-1
set spelllang=en_gb
set statusline=%<%f\ %h%m%r%=\ [line\ %l\ of\ %L]\ [col\ %v]\ [0x%B]
set suffixes=.bak,~,.o,.info,.swp,.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set switchbuf=useopen,usetab,newtab
set synmaxcol=500
set tabpagemax=500
set tabstop=4
set termguicolors
set textwidth=80
set tildeop
set title
set undodir=~/.vim/tmp/undo
set undofile
set updatecount=50
set viewdir=~/.vim/tmp/view
set viminfo='50,<0,n~/.vim/tmp/viminfo
set wildignore=*.o,*.pyc,*.png,*.jpg
set wildignorecase
set wildmenu
set wildmode=list:longest
set nowrapscan
" vim: set ft=vim :
