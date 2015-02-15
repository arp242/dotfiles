# vim:set syntax=tcsh
# $logid$

# Show the directory in the xterm title
echo -n "\033]2;tcsh: $cwd\007"

# Interferes with running commands
unset printexitvalue

# For sanity
set backslash_quote

# stat would be better/faster, but stat is about as unportable as it gets
alias __pstat 'perl -e \'print((stat($ARGV[0]))[9])\''

# TODO: alias precmd

# Some games for the sake of efficiency
if ( $?reporoot ) then
	if ( "$cwd" =~ "$reporoot*" ) then
		if ( $repotype == 'git' && $repochanged == `__pstat "$reporoot"/.git/HEAD` ) then
			goto end
		endif
		if ( $repotype == 'hg' && $repochanged == `__pstat "$reporoot"/.hg/undo.branch` ) then
			goto end
		endif
	else
		unset repotype
		unset reporoot
		unset repochanged
	endif
endif

if ( ! $?repotype ) set repotype = ''

# Mercurial
if ( ! $?reporoot || $repotype == 'hg' ) then
	hg branch >& /dev/null
	if ( $? == 0 ) then
		set reporoot = `hg root`
		set repotype = 'hg'
		set repochanged = `__pstat "$reporoot"/.hg/undo.branch`
		set prompt = "[%~](`cat $reporoot/.hg/undo.branch`)%# "

		goto end
	endif
endif


# Git
if ( ! $?reporoot || $repotype == 'git' ) then
	git rev-parse --abbrev-ref HEAD >& /dev/null
	if ( $? == 0 ) then
		set reporoot = `git rev-parse --show-toplevel`
		set repotype = 'git'
		set repochanged = `__pstat "$reporoot"/.git/HEAD`
		set prompt = "[%~](`git rev-parse --abbrev-ref HEAD`)%# "

		goto end
	endif
endif


# We're not in a repo anymore; reset.
set prompt = "[%~]%# "
unset repotype
unset reporoot
unset repochanged


# Cleanup
# TODO: Detect if these options were set in the first place, rather than setting
# them here...
end:
	set printexitvalue
	unset backslash_quote
	unalias __pstat
