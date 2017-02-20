" $dotid$

" This helper allows us to define macros in a maintainable manner; it's a
" (slightly simpler) version of the re.X flag:
"
" - whitespace at the start and end of lines is ignored.
" - everything after # is ignored.
"
" Use "\x23" if you want a literal #.

python3 << EOF
import re, vim
def macro(letter, macro):
	vim.command('let @{}="{}"'.format(letter,
		''.join([re.sub('#.*', '', l).strip() for l in macro.split('\n')]).replace('"', r'\"')))
EOF

" Add KO translation string
python3 << EOF
macro('t', '''
	f>l                                              # Put cursor after >
	vt<xh                                            # Remove everything insde the tag
	i data-bind=\"text: app.tl('\<Esc>pa')\"\<Esc>"  # Put what we yanked in KO syntax
''')
EOF
