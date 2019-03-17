augroup basic
    au!

    " Go to the last cursor location when a file is opened, unless this is a git
    " commit (in which case it's annoying).
    au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit'
            \| exe 'normal! g`"'
        \| endif

    " Never spellcheck urls.
    au BufReadPost * syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
augroup end

" Preferences for various filetypes.
augroup my_filetypes
    au!

    " Don't need the syntax highlighting for git commits; don't like it at all.
    au FileType gitcommit
        \  setl syntax=OFF ts=8
        \| syn match gitcommitComment "^#.*"

    " Reset some settings that these ftplugins or syntax files reset :-/
    au FileType python setl ts=4
    au FileType sass   setl noexpandtab sw=4

    " Remove Python 2 keywords.
    au Syntax python
        \ syn keyword pythonTwoBuiltin basestring cmp execfile file long unichr
        \     raw_input reduce reload unicode xrange apply buffer coerce intern

    " 2 spaces is almost universal.
    au FileType yaml setl expandtab ts=2

    " C files are almost always ts=8, and very often mix tabs and spaces.
    au FileType c,cpp setl ts=8

    " Set tabstop for Makefile, config files, etc.
    au BufNewFile,BufRead [Mm]akefile*,crontab*,*rc,*.conf,*.ini,*.cfg,*.rc setl ts=8

    " Set larger textwidth for HTML.
    au FileType html,htmldjango,eruby,haml setl textwidth=100

    " Fix 'temp file must be edited in place' on some platforms.
    au FileType crontab setl backupcopy=yes

    " My todo-file is in Markdown.
    au BufRead,BufNewFile TODO setl filetype=markdown

    " Spaces work better, and don't round indenting by shiftwidth (mucks up
    " marking stuff as code).
    au FileType markdown setl expandtab noshiftround

    " Italics don't work well in tmux; shows black background. Loads of people
    " with the issue, but can't get it to work, so just disable it :-(
    au FileType markdown,html,gohtml,htmldjango,xhtml
                \  if $TMUX isnot ''
                \|   hi htmlItalic cterm=underline
                \| endif

    " Highlight trailing spaces in Markdown
    au FileType markdown
        \  highlight MarkdownTrailingSpaces ctermbg=green guibg=green
        \| call matchadd('MarkdownTrailingSpaces', '\s\+$', 100)

    " Set textwidth to 76 for emails.
    au BufReadPost /tmp/mail-* setl ft=mail | normal! 0Go
    au FileType mail setl textwidth=76

    " These emails are usually DOS formatted (as should be, per RFC).
    au BufReadPost *.eml setl fileformats+=dos fileformat=dos | edit!

    " Make editing SSH authorized_keys and known_hosts less painful.
    au BufReadPost authorized_keys,known_hosts
        \ setl nowrap noautoindent nosmartindent textwidth=0 formatoptions=

    " Works better most of the time.
    au FileType json,xml setl nowrap

    " Show formatting characters only in insert mode and load vimhelplint.
    au FileType help
                \| if &modifiable
                \|   setl colorcolumn=78
                \|   silent! packadd! vim-vimhelplint
                \|   augroup help_insert
                \|     au InsertEnter <buffer> setl conceallevel=0 | highlight clear Ignore
                \|     au InsertLeave <buffer> setl conceallevel=2
                \|   augroup end
                \| endif

    " Very common in CSS; not sure why this isn't there by default? Hmm.
    au FileType css setl isk+=-

    " Get MDN help for current element; works for CSS and HTML.
    " TODO: check out:
    "   https://github.com/stephenmckinney/vim-dochub
    "   https://github.com/romainl/vim-devdocs
    au FileType css,html,gohtml,htmldjango,xhtml
                \  setl keywordprg=:MDN
                \| command! -nargs=1 MDN call system(printf(
                \          'firefox https://developer.mozilla.org/en-US/docs/Web/%s/%s',
                \          (&ft is# 'css' ? 'CSS' : 'HTML/Element'), <f-args>))
augroup end

" is# and isnot# won't work otherwise. Emailed syntax maintainer on 20190309.
augroup fix_vimscript
    au!
    au FileType vim syn match vimOper
                \ "\(==\|!=\|>=\|<=\|=\~\|!\~\|>\|<\|=\|isnot\|is\)[?#]\{0,2}"
                \ skipwhite nextgroup=vimString,vimSpecFile
augroup end


" vim:expandtab
