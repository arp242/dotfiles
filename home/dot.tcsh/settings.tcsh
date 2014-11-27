# Basic corrections when completing
set autocorrect

# Show options when autocompleting
set autolist

# Use history to aid expansion
set autoexpand

# Never autologout
set autologout

set complete=Enhance

#       If the complete shell variable  is  set  to  `enhance',  completion  1)
#       ignores  case  and  2) considers periods, hyphens and underscores (`.',
#       `-' and `_') to be word separators and hyphens and  underscores  to  be
#       equivalent.  If you had the following files
#
#           comp.lang.c      comp.lang.perl   comp.std.c++
#           comp.lang.c++    comp.std.c
#
#       and  typed  `mail  -f  c.l.c[tab]',  it  would be completed to `mail -f
#       comp.lang.c', and ^D  would  list  `comp.lang.c'  and  `comp.lang.c++'.
#       `mail  -f  c..c++[^D]'  would  list `comp.lang.c++' and `comp.std.c++'.
#       Typing `rm a--file[^D]' in the following directory
#
#           A_silly_file    a-hyphenated-file    another_silly_file
#
#       would list all three files, because case is  ignored  and  hyphens  and
#       underscores  are  equivalent.   Periods, however, are not equivalent to
#       hyphens or underscores.
#
#       if the complete shell variable is set to `Enhance', completion  ignores
#       case  and differences between a hyphen and an underscore word separator
#       only when the user types a lowercase character or a  hyphen.   Entering
#       an  uppercase character or an underscore will not match the correspond‐
#       ing  lowercase  character  or  hyphen  word  separator.    Typing   `rm
#       a--file[^D]'  in the directory of the previous example would still list
#       all  three  files,  but  typing   `rm   A--file'   would   match   only
#       `A_silly_file'   and   typing   `rm   a__file[^D]'   would  match  just
#       `A_silly_file' and `another_silly_file'  because  the  user  explicitly
#       used an uppercase or an underscore character.
#
#       Completion  and  listing are affected by several other shell variables:
#       recexact can be set to complete on the shortest possible unique  match,
#       even if more typing might result in a longer match:
#
#           > ls
#           fodder   foo      food     foonly
#           > set recexact
#           > rm fo[tab]
#
#       just beeps, because `fo' could expand to `fod' or `foo', but if we type
#       another `o',
#
#           > rm foo[tab]
#           > rm foo
#
#       the completion completes on `foo', even though `food' and `foonly' also
#       match.   autoexpand can be set to run the expand-history editor command
#       before each completion attempt, autocorrect can be set to spelling-cor‐
#       rect  the  word  to  be completed (see Spelling correction) before each
#       completion attempt and correct can be set to complete commands automat‐
#       ically  after  one hits `return'.  matchbeep can be set to make comple‐
#       tion beep or not beep in a variety of situations, and nobeep can be set
#       to  never  beep  at  all.   nostat  can be set to a list of directories
#       and/or patterns that match directories to prevent the completion mecha‐
#       nism from stat(2)ing those directories.  listmax and listmaxrows can be
#       set to limit the number of  items  and  rows  (respectively)  that  are
#       listed  without asking first.  recognize_only_executables can be set to
#       make the shell list only executables when listing commands, but  it  is
#       quite slow.
#
#       Finally, the complete builtin command can be used to tell the shell how
#       to complete words other than filenames, commands and  variables.   Com‐
#       pletion  and listing do not work on glob-patterns (see Filename substi‐
#       tution), but the list-glob  and  expand-glob  editor  commands  perform
#       equivalent functions for glob-patterns.



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
