helpline.vim: the truly light-weight statusline plugin.

It's different from [vim-airline](https://github.com/bling/vim-airline),
[powerline](https://github.com/powerline/powerline), and
[lightline](https://github.com/itchyny/lightline.vim) in that it doesn't
completely revamp the statusline and turn it in a friggin' Christmas tree.
Instead, it just provides some helper functions to build a statusline (hence the
name, *help*line). After installation, nothing will have changed in your
statusline.

It also doesn't try to completely re-invent the `statusline` syntax. There is no
need to. You can already evaluate expressions inside the statusline with `%{`,
for example `%{&filetype}` will put the filetype in the statusline.  
The problem with this is that it will be run *every time* the screen is updated
(e.g. when moving the cursor, typing a character, etc.). This isn't a problem
when displaying some basic information such as the line number, filename, or
value of a setting, but *does* become a problem when displaying more advanced
information such as the current git branch, current function name, etc.

helpline.vim allows you to easily control when parts of the statusline are
updated.

And that is really all that's needed to enhance the statusline.

How to use it
=============
A brief example:

	set statusline=${BufNewFile,BufReadPost,BufEnter system('git rev-parse --abbrev-ref HEAD')}

This will insert the result of the `system()` function when the `BufNewFile`,
`BufReadPost`, or `BufEnter` are run.

Luckily helpline.vim comes with some shortcuts for common operations. First of
all, there are some common `autocmd` shortcuts:

	set statusline=${new system('git rev-parse --abbrev-ref HEAD')}

And many common operations have functions so you don't have to reinvent the
wheel

	set statusline=${new helpline#branch_name()}

Colours
-------
The second problem is using colours, which can be a bit cumbersome.

	highlight StatuslineGrey ctermbg=0 ctermfg=251 cterm=bold
	autocmd ColorScheme *
		\ highlight StatuslineGrey ctermbg=0 ctermfg=251 cterm=bold

	set statusline=%#StatusLineGrey#%{&ft}%#Statusline#

So lets shortcut that:

	call helpline#define_color('grey', 'ctermbg=0 ctermfg=245 cterm=bold')
	set statusline=@{grey &ft}

Mixing it with the `${}` syntax:

	set statusline=@{grey ${new system('git rev-parse --abbrev-ref HEAD')}}

Conditionals
------------
Sometimes you want to add something to the statusline only one particular
filetypes:

	let &stl .= "${CursorHold go#complete#GetInfo()}"

We only want this for `&ft == 'go'`, but doing:

	if &ft == 'go'
		let &stl .= "${CursorHold go#complete#GetInfo()}"
	endif

Will not work, since the vimrc is read on startup *only*, before the filetype is
set.

This can be done like so:

	autocmd FileType *
		\| let &stl .= '%<%f'
		\| if &ft == 'go'
		\|	let &stl .= "${CursorHold go#complete#GetInfo()}"
		\| endif

Or perhaps more readable:

	fun! s:set_stl()
		let &stl .= '%<%f'
		if &ft == 'go'
			let &stl .= "${CursorHold go#complete#GetInfo()}"
		endif

		call helpline#process()
	endfun
	autocmd FileType * call s:set_stl()
