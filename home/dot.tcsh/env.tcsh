if ($uname != win32) then
	setenv PATH ~/Local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games

	if (-d /usr/local/bin) then
		setenv PATH ${PATH}:/usr/local/bin:/usr/local/sbin
	endif
	if ($prefix != 0) then
		setenv PATH ${PATH}:${prefix}/bin:${prefix}/sbin
	endif
endif

# Some commonly installed packages on OpenSolaris
if ($uname == SunOS) then
	setenv PATH ${PATH}:/opt/VirtualBox:/opt/csw/gcc4/bin
endif

if ( -d "$HOME/.gem/ruby/2.1.0/bin" ) then
	setenv PATH "${PATH}:$HOME/.gem/ruby/2.1.0/bin/"
endif

# /var/ is a memory device on my laptop
if ($uname == FreeBSD && -d /pkgdb) setenv PKG_DBDIR /pkgdb/

# Various applications settings
setenv PAGER less
setenv LESS "--ignore-case --LONG-PROMPT --SILENT --no-init --no-lessopen"

setenv BLOCKSIZE K
setenv MANWIDTH 80
setenv LS_COLORS "no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=31:"
setenv GREP_COLOR 31 # red
# Also red, for just the matching part (as above)... Newer GNU greps seem to
# "require" this to prevent x-mas tree syndrome
setenv GREP_COLORS "ms=31:mc=31:sl=0:cx=0:fn=0:ln=0:bn=0:se=0"

if (($?TMUX)) then
	setenv TERM screen
else if ($uname == OpenBSD) then
	# Seems to work better on OpenBSD ...
	setenv TERM xterm-xfree86
else if ($uname == FreeBSD) then
	if ($tty =~ ttyv*) then
		setenv TERM cons25
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
	setenv LC_COLLATE C
endif

if ($uname == OpenBSD) then
	setenv PKG_PATH "ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/"
	setenv CVSROOT "anoncvs@anoncvs.fr.openbsd.org:/cvs"
endif

# Set editor
if (-X vim) then
	setenv EDITOR vim
	alias vim 'vim -p'
	alias vi "vim"
else if (-X vi) then
	setenv EDITOR vi
endif

# Set browser
if (-X opera) setenv BROWSER opera

# https://www.pekwm.org/projects/pekwm/tasks/350
setenv GDK_CORE_DEVICE_EVENTS 1
