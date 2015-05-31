fun! Fmt()
	" The cursor is left on the first non-blank of the last formatted line.
	let l:end = ' "'
	let l:start = '"'

	"http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
	"synIDattr(synID('', '', 0), "name")

	"The |v:lnum|  variable holds the first line to be formatted.
	"The |v:count| variable holds the number of lines to be formatted.
	"The |v:char|  variable holds the character that is going to be
	"	      inserted if the expression is being evaluated due to
	"	      automatic formatting.  This can be empty.  Don't insert
	"	      it yet!
	"
	echo v:lnum . ' ' . v:count . ' ' . v:char
endfun
"set formatexpr=Fmt()

