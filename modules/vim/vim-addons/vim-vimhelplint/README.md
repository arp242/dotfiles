vim-vimhelplint
============

# How to use
1. Install **vim-vimhelplint**
    - Copy `ftplugin/help_lint.vim` to your `~/.vim/ftplugin/help_lint.vim`.
    - Or you can use your favorite plugin managers ([Vundle](https://github.com/gmarik/Vundle.vim), [Neobundle](https://github.com/Shougo/neobundle.vim), [vim-plug](https://github.com/junegunn/vim-plug)).
    ```vim
    " Vundle
    Plugin 'machakann/vim-vimhelplint'

    " Neobundele
    NeoBundle 'machakann/vim-vimhelplint'

    " vim-plug
    Plug 'machakann/vim-vimhelplint'
    ```

2. Open vim and edit your help file. `:edit path/to/your_help_file.txt`

3. Execute an ex command `:VimhelpLint`, then it registers errors to quickfix list. Thus, for example, use `:copen` to check quickfix window. If you use `:VimhelpLint!`, it opens quickfix window automatically.
