" ALE: Asynchronous Lint Engine

let g:ale_lint_on_text_changed = 'never'  " Don't check when typing.
let g:ale_lint_on_enter = 0               " Don't lint when opening files.
let g:ale_fix_on_save = 1                 " Format code for me on :w
let g:ale_set_signs = 0                   " Don't set signs.

"set omnifunc=ale#completion#OmniFunc

let g:ale_completion_enabled = 1
let g:ale_completion_delay = 1000
"set omnifunc=ale#completion#OmniFunc

" Fixers
"
"  'add_blank_lines_for_python_control_statements' - Add blank lines before control statements.
"  'autopep8' - Fix PEP8 issues with autopep8.
"  'black' - Fix PEP8 issues with black.
"  'isort' - Sort Python imports with isort.
"  'remove_trailing_lines' - Remove all blank lines at the end of a file.
"  'trim_whitespace' - Remove all trailing whitespace characters at the end of every line.
"  'yapf' - Fix Python files with yapf.
let g:ale_fixers = {
	\ 'python': ['autopep8'],
	\ 'go':     ['goimports'],
	\ 'rust':   ['rustfmt'],
	\ 'gomod':  ['gomod'],
	\ 'sh':     ['shfmt'],
	\ }

let g:ale_sh_shfmt_options = ' -ci -s -kp -ln posix '

" Available Linters: ['flake8', 'mypy', 'prospector', 'pycodestyle', 'pyflakes', 'pylint', 'pyls', 'pyre', 'vulture']
"  Enabled Linters: ['flake8', 'mypy', 'pylint']

" Linters
"let g:ale_linters = {'go': ['golangserver', 'go build', 'gometalinter']}
let g:ale_linters = {'go': ['golangserver', 'go build', 'gometalinter']}
"let g:ale_linters = {'go': ['golangci-lint']}
"let g:ale_linters = {'go': ['golangcilint']}
" TODO: doesn't work:
"let g:go_golangci_lint_package=1
let g:ale_go_gobuild_options = '-tags testdb'

let g:gometalinter_fast = ''
			\ . ' --enable=vet'
			\ . ' --enable=errcheck'
			\ . ' --enable=ineffassign'
			\ . ' --enable=goimports'
			\ . ' --enable=misspell'
			\ . ' --enable=lll --line-length=120'

" These are slow (>2s)
let g:gometalinter_slow = ''
            \ . ' --enable=varcheck'
            \ . ' --enable=interfacer'
            \ . ' --enable=unconvert'
            \ . ' --enable=structcheck'
            \ . ' --enable=megacheck'

let g:ale_go_gometalinter_options = '--disable-all --tests' . g:gometalinter_fast . ' --enable=golint'

command! NoGolint let g:ale_go_gometalinter_options = '--disable-all' . g:gometalinter_fast

"let g:ale_go_gometalinter_options = '--disable-all' . g:gometalinter_fast . g:gometalinter_slow
"augroup ale_gometalinter
"    autocmd!
"    autocmd User ALELintPre  let   b:ale_go_gometalinter_options = '--disable-all' . g:gometalinter_fast
"    autocmd User ALELintPost unlet b:ale_go_gometalinter_options
"augroup end
