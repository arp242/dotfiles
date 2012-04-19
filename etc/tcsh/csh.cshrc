# $FreeBSD: release/9.0.0/etc/csh.cshrc 50472 1999-08-27 23:37:10Z peter $
#	$OpenBSD: csh.cshrc,v 1.2 1996/05/26 10:25:19 deraadt Exp $
#
# tcsh configuration
# Martin Tournoij <martin@arp242.net>
# Should work on: FreeBSD, OpenBSD, Linux, OpenSolaris
#

# NetBSD
if (-d /usr/pkg/bin) then
	set prefix = /usr/pkg
# OpenSolaris
else if (-d /opt/csw/bin) then
	set prefix = /opt/csw
# FreeBSD, OpenBSD
else if (-d /usr/local/bin) then
	set prefix = /usr/local
endif

set uname = `uname`

##################################################
# Environment
#################################################
umask 022

setenv PATH ~/bin
setenv PATH ${PATH}:/sbin:/bin:/usr/sbin:/usr/bin
if (-d /usr/X11R6/bin) then
	setenv PATH ${PATH}:/usr/X11R6/bin:/usr/X11R6/sbin
endif
if (-d /usr/local/bin) then
	setenv PATH ${PATH}:/usr/local/bin:/usr/local/sbin
endif
setenv PATH ${PATH}:${prefix}/bin:/${prefix}/sbin
setenv PATH ${PATH}:/usr/games

# Some commonly installed packages on OpenSolaris
if ($uname == SunOS) then
	setenv PATH ${PATH}:/opt/VirtualBox
	setenv PATH ${PATH}:/opt/csw/gcc4/bin
endif

# /var/ is a memory device on my laptop
if ($uname == FreeBSD && -d /pkgdb) then
	setenv PKG_DBDIR /pkgdb/
	setenv PKG_TMPDIR /tmp/
endif

# Various applications settings
setenv PAGER less
# --squeeze-blank-lines
# --chop-long-lines
setenv LESS "--ignore-case --LONG-PROMPT --SILENT --tabs=2 --no-init"

setenv BLOCKSIZE K
setenv LS_COLORS "no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=01;31:"
setenv GREP_COLOR 31
setenv ACK_COLOR_FILENAME red

if ($uname == OpenBSD) then
	# Seems to work better on OpenBSD ...
	setenv TERM xterm-xfree86
else if ($uname == FreeBSD) then
	if ($tty =~ ttyv*) then
		setenv TERM cons25
		/usr/sbin/kbdcontrol -r fast
	else
		setenv TERM xterm-color
	endif
else if ($uname == Linux) then
	setenv TERM xterm-color
else
	setenv TERM vt220
endif

# UTF-8
if (-X locale) then
	setenv LANG en_US.UTF-8
	setenv LC_CTYPE en_US.UTF-8
endif

if ($uname == FreeBSD) then
	setenv CFLAGS '-I/usr/local/include/'
	setenv LDFALGS '-L/usr/local/lib/'
	setenv CVSROOT ":pserver:anoncvs@anoncvs.fr.FreeBSD.org:/home/ncvs"
else if ($uname == OpenBSD) then
	setenv CFLAGS '-I/usr/local/include/'
	setenv LDFALGS '-L/usr/local/lib/'
	setenv PKG_PATH "ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/"
	setenv CVSROOT "anoncvs@anoncvs.fr.openbsd.org:/cvs"
endif

# Set editor
if (-X vim) then
	setenv EDITOR vim
	alias vi "vim"
else if (-X vi) then
	setenv EDITOR vi
endif

# Set browser
if (-X opera) then
	setenv BROWSER opera
else if (-X elinks) then
	setenv BROWSER elinks
else if (-X links) then
	setenv BROWSER links
else if (-X lynx) then
	setenv BROWSER lynx
endif

#################################################
# Settings
#################################################
# Basic corrections when completing
set autocorrect

# Show options when autocompleting
set autolist

# Use history to aid expansion
set autoexpand

# Never autologout
set autologout

# Smarter completion
#set complete = enhance

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

# Show current dir.
set prompt = "[%~]%# "

# Use % for normal user and # for super
set promptchars = "%#"

# Don't beep
set nobeep

# Don't allow > redirection on existing files (only >>)
set noclobber

# Print exit value if >0
set printexitvalue

# Ask for confirmation if we do rm *
set rmstar

# Show date&hostname on right side
set rprompt = "%m:%T"

# Save history
set savehist = 8192 merge

#################################################
# Aliases
#################################################
# "Special" aliases
# Update xterm title on directory change
alias cwdcmd 'echo -n "\033]2;tcsh: $cwd\007"'

# Modestly color my ls. But not christmas tree Linux colors! (See environment
# variable $LS_COLOR above)
if ($uname == FreeBSD) then
	alias ls "ls-F -I"
	alias la "ls-F -A"
	alias lc "ls-F -lThoI"
	alias lac "ls-F -lThoA"

	# bsdgrep is FreeBSD >=9
	if (-X bsdgrep) then
		alias grep "bsdgrep --color"
	else
		alias grep "bsdgrep --color"
	endif

	alias pdiff "diff -urN -x CVS -x .svn -I '^# .FreeBSD: '"
else if ($uname == OpenBSD) then
	if (-X colorls) then
		alias ls "colorls -FG"
		alias la "colorls -FGA"
		alias lc "colorls -FGlTho"
		alias lac "colorls -FGlThoA"
	else
		alias ls "ls -F"
		alias la "ls -FA"
		alias lc "ls -FlTho"
		alias lac "ls -FAlTho"
	endif

	alias grep "grep --color"
	alias pdiff "diff -urN -x CVS -x .svn -I '^# .OpenBSD: '"
else if ($uname == SunOS) then
	alias ls "ls-F"
	alias la "/bin/ls -FA"
	alias lc "/bin/ls -Flho"
	alias lac "/bin/ls -FlAho"
else if ($uname == Linux) then
	unalias ls
	alias ls ls-F
	alias lc ls -lh
	alias la ls -A
	alias lac ls -lhA
else
	# These should work on almost any platform ...
	alias la "ls -a"
	alias lc "ls -l"
	alias lac "ls -la"
endif

# Override the tcsh builtins
if (-x /usr/bin/nice) then
	alias nice "/usr/bin/nice"
else if (-x /bin/nice) then
        alias nice "/bin/nice"
endif

if (-x /usr/bin/time) then
	alias time "/usr/bin/time -h"
endif

# A few move aliases...
alias cp "cp -i"
alias mv "mv -i"
alias make "nice -n 20 make"
alias lman "groff -man -Tascii"
alias j "jobs -l"

# Third-party stuff
if (-X mplayer) then
	alias music "mplayer -cache-min 0 $* *.{mp3,flac}"
endif

# Some programs are hard coded to launch firefox ... :-/
if (-X opera) then
	alias opera "opera -nomail"
	alias firefox "opera"
endif

alias youtube-dl 'youtube-dl -t'
alias turboturbofull  'xfreerdp -x lan -u carpetsmoker -f -o 192.168.3.11'
alias turboturbo  'xfreerdp -x lan -u carpetsmoker -g 1024x768 -o 192.168.3.11'
alias xangband "angband -mx11 -- -n3"
alias xtome "tome -mx11 -- -n3"

if (-X xtermset) then
	alias xt "xtermset -title"
	alias black "xtermset -fg white -bg black"
	alias white "xtermset -fg black -bg white"
else if (-X xtermcontrol) then
	alias xt "xtermcontrol --title"
	alias black "xtermcontrol --fg=white --bg=black"
	alias white "xtermcontrol --fg=black --bg=white"
endif

# Typos
alias -	 "cd -"
alias sl "ls"
alias l	 "ls"
alias c	 "cd"
alias vo "vi"
# I know ci is already a command, but not used often and it mangles files!
alias ci "vi"
alias grpe "grep"
alias Grep "grep"

alias helpcommand man

#################################################
# Keybinds
#################################################
# Delete
bindkey ^[[3~	delete-char

# Home
bindkey ^[[H	beginning-of-line
bindkey ^[[1~	beginning-of-line

# End
bindkey ^[[F	end-of-line
bindkey ^[[4~	end-of-line

# F1
bindkey ^[[M	run-help
bindkey OP	run-help

# Arrow keys
bindkey -k up	history-search-backward
bindkey -k down	history-search-forward

# Insert
bindkey ^[[L	overwrite-mode
bindkey ^[[2~	overwrite-mode

#################################################
# Completion
#################################################
# Show directories only
complete cd 'C/*/d/'
complete rmdir 'C/*/d/'

#complete kill 'c/-/S/' 'p/1/(-)//'
complete kill 'c/-/S/' 'n/*/`ps -axco pid= | sort`/'
complete pkill 'c/-/S/' 'n/*/`ps -axco command= | sort -u`/'

# Use available commands as arguments
complete which 'p/1/c/'
complete where 'p/1/c/'
complete man 'p/1/c/'
complete apropos 'p/1/c/'

# aliases
complete alias 'p/1/a/'
complete unalias 'p/1/a/'

# variables
complete unset 'p/1/s/'
complete set 'p/1/s/'

# environment variables
complete unsetenv 'p/1/e/'
complete setenv 'p/1/e/'

# limits
complete limit 'p/1/l/'

# key bindings
complete bindkey 'C/*/b/'

# groups
complete chgrp 'p/1/g/'

# users
# XXX Support user:group completion
complete chown 'p/1/u/'

# You can use complete to provide extensive help for complex commands
# like find.  
# Please check your version before using these completions, as some
# differences may exist.
complete find \
	'n/-name/f/' 'n/-newer/f/' 'n/-{,n}cpio/f/' \
	'n/-exec/c/' 'n/-ok/c/' 'n/-user/u/' 'n/-group/g/' \
	'n/-fstype/(nfs 4.2)/' 'n/-type/(b c d f l p s)/' \
	'c/-/(name newer cpio ncpio exec ok user group fstype type atime \
	ctime depth inum ls mtime nogroup nouser perm print prune \
	size xdev and or)/' \
	'p/*/d/'

# set up programs to complete only with files ending in certain extensions
complete cc 'p/*/f:*.[cao]/'
complete python 'p/*/f:*.py/'
complete perl 'p/*/f:*.pl/'
#complete sh 'p/*/f:*.sh/'

# of course, this completes with all current completions
complete uncomplete 'p/*/X/'

# set a list of hosts
set hostlist=(glitch colo xs7.xs4all.nl aragorn.nl)
complete ssh 'p/1/$hostlist/' 'p/2/c/'

#  complete [command [word/pattern/list[:select]/[[suffix]/] ...]] (+)
if ($uname == FreeBSD) then
	complete sysctl 'n/*/`sysctl -Na`/'
	complete service 'n/*/`service -l`/'

	complete pkg_delete 'c/-/(i v D n p d f G x X r)/' 'n@*@`/bin/ls /var/db/pkg`@'
else if  ($uname == Linux) then
	# Use /bin/ls to prevent ls options interfering (i.e. adding a *)
	complete service 'n@*@`/bin/ls /etc/init.d`@' 
endif

# Only list make targets
complete make 'n@*@`make -pn | sed -n -E "/^[#_.\/[:blank:]]+/d; /=/d; s/[[:blank:]]*:.*//gp;"`@'
