" vim:noexpandtab:ts=8:sts=8:sw=8
" $hgid: fa3e06dce8e5
"
" This vimrc has been compiled from many, *many* sources over the years, and
" I've added a number of innovations of my own.

try
	" This allows doing:
	" :let env = "work"
	" :source ~/.vimrc
	" To re-set the settings to the new env
	let env = env
catch /E121/
	" I keep the company code in ~/code/, if we're outside of that, assume
	" we're *not* using the company code style
	if hostname() =~ "martin-xps" && strpart(getcwd(), 0, strlen($HOME) + 5) == "$HOME/code"
		let env = "work"
	else
		let env = "personal"
	endif
endtry


execute pathogen#infect()


source ~/.vim/functions.vim
source ~/.vim/options.vim
source ~/.vim/keys.vim
source ~/.vim/languages.vim
source ~/.vim/plugins.vim

if has("gui_running")
	source ~/.vim/gui.vim
endif
