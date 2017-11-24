" ALE: Asynchronous Lint Engine

let g:ale_lint_on_text_changed = 'never'  " Don't check when typing.
let g:ale_lint_on_enter = 0               " Don't check on open
let g:ale_vim_vint_show_style_issues = 0  " Too many annoying style issues
let g:ale_fix_on_save = 1                 " Format code for me on :w
"let g:ale_open_list = 1                   " Open loclist.

" Fixers
let g:ale_fixers = {'go': ['goimports']}

" Linters
let g:ale_linters = {'go': ['gometalinter']}
let g:ale_go_gometalinter_options = '--disable-all'
			\ . ' --enable=vet'
			\ . ' --enable=golint'
			\ . ' --enable=errcheck'
			\ . ' --enable=ineffassign'
			\ . ' --enable=goconst'
			\ . ' --enable=goimports'
			\ . ' --enable=lll --line-length=120'
            " These are slow (>2s)
            " \ . ' --enable=varcheck'
            " \ . ' --enable=interfacer'
            " \ . ' --enable=unconvert'
            " \ . ' --enable=structcheck'
            " \ . ' --enable=megacheck'
