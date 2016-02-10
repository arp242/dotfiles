# $logid$

# Basic corrections when completing
set autocorrect

# Show options when autocompleting
set autolist

# Use history to aid expansion
set autoexpand

# Never autologout
set autologout

# Makes tab-completion:
# - ignore case, unless a capital is types
# - difference between hyphen and underscore
set complete=Enhance

# Colorize ls-F
set color

# set -n and set '\003' will both work
set echo_style=both

# file completion
set filec

# Keep n items in history
set history = 8192

# Logout on ^D
unset ignoreeof

# Show '>' for symlink to dir, and '&' for symlink to nowhere
set listlinks

# List all jobs after ^Z
set listjobs

# Show current dir
set prompt = "[%~]%# "

# Blue prompt if we're in a sandbox
if ( ${?SANDBOX} == 1 ) then
	set blue = "%{\033[34m%}"
	set end = "%{\033[0m%}"
	set prompt = "[%~]${blue}%#${end} "
endif

# Use % for normal user and # for super
set promptchars = "%#"

# Show date & hostname on right side
set rprompt = "%B%U%m%b%u:%T"

# Never print "DING!" as the time
set noding

# Don't beep
set nobeep

# Ask before doing > redirection on non-empty existing files
set noclobber = (notempty ask)

# Print exit value if >0
set printexitvalue

# Ask for confirmation if we do rm *
set rmstar

# Save history
set savehist = 8192 merge

# Save history here
set histfile=~/.tcsh/history

# Lists file name suffixes to be ignored by completion
set fignore = (.pyc)

# Allow ** for recursive glob
set globstar

# No need for rehash
set autorehash

# Don't go to homedir when we use cd without arguments
set noimplicithome

# Set the histchars to empty (default: !^), since I never use this feature, and
# it's only annoying (since the ! has special escaping needs)
set histchars
