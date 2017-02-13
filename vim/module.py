dirs = {
	'~/.vim': '.',
}

symlinks = {
	# Required for some older versions of Vim
	'~/.vim/vimrc': '~/.vimrc',

	# Neovim
	#'~/.vim/vimrc': '~/.vim/init.vim',
}

# TODO: Define custom run() function which copies spellfiles from dest to src if
# this is martin-xps, otherwise always copy from src to dest
