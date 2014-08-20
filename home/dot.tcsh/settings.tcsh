# Basic corrections when completing
set autocorrect

# Show options when autocompleting
set autolist

# Use history to aid expansion
set autoexpand

# Never autologout
set autologout

# Colorize stuff
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

# Use % for normal user and # for super
set promptchars = "%#"

# Show date & hostname on right side
set rprompt = "%B%U%m%b%u:%T"

# Never print "DING!" as the time
set noding

# Don't beep
set nobeep

# Don't allow > redirection on existing files (only >>)
set noclobber

# Print exit value if >0
set printexitvalue

# Ask for confirmation if we do rm *
set rmstar

# Save history
set savehist = 8192 merge

# Lists file name suffixes to be ignored by completion
set fignore = (.pyc)

# Allow ** for recursive glob
set globstar
