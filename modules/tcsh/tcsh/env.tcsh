# $logid$

# Setup PATH
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
if ($uname == SunOS) setenv PATH ${PATH}:/opt/VirtualBox:/opt/csw/gcc4/bin

# TODO: On my system, I have one dir here (2.1.0), but this may not be the only
# one (it also doesn't correspond to my ruby or gem version ...) We should get
# the '2.1.0' from somewhere...
if ( -d "$HOME/.gem/ruby" ) setenv PATH "${PATH}:$HOME/.gem/ruby/2.2.0/bin/"

# Various applications settings
setenv BLOCKSIZE K
setenv PAGER less
setenv LESS "--ignore-case --LONG-PROMPT --SILENT --no-init --no-lessopen"

# Make man pages 80 characters wide at the most; this is the default on BSD, but
# not Linux
setenv MANWIDTH 80

# Colors for ls(1)
setenv LS_COLORS "no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=31:"

# Older GNU grep; BSD grep
setenv GREP_COLOR 31

# Newer GNU grep, I guess GREP_COLOR was too easy to use
setenv GREP_COLORS "ms=31:mc=31:sl=0:cx=0:fn=0:ln=0:bn=0:se=0"

# Fix scrolling in GTK3; https://www.pekwm.org/projects/pekwm/tasks/350
setenv GDK_CORE_DEVICE_EVENTS 1

# Make compose key work for GTK, Qt
setenv GTK_IM_MODULE xim
setenv QT_IM_MODULE xim

# Don't output to a pager
setenv SYSTEMD_PAGER

# /var/ is a memory device on my laptop
if ($uname == FreeBSD && -d /pkgdb) setenv PKG_DBDIR /pkgdb/

if ($uname == OpenBSD) then
	setenv PKG_PATH "ftp://ftp.openbsd.org/pub/OpenBSD/`uname -r`/packages/`uname -m`/"
	setenv CVSROOT "anoncvs@anoncvs.fr.openbsd.org:/cvs"
endif

# Do the $TERM dance; these options seem to work best on various systems...
if (($?TMUX)) then
	setenv TERM screen
else if ($uname == OpenBSD) then
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

	# Sort in a "sane" manner, ie. with capitals first
	setenv LC_COLLATE C
endif

# Set editor
if (-X vim) then
	setenv EDITOR vim
	alias vim "vim -p"
	alias vi "vim"
else if (-X vi) then
	setenv EDITOR vi
endif

# Set browser
if (-X dwb) then
	setenv BROWSER dwb
else if (-X opera) then
	setenv BROWSER opera
endif

# Set DISPLAY on remote login
if ( $?REMOTEHOST && ! $?DISPLAY ) then 
	setenv DISPLAY ${REMOTEHOST}:0
endif

# Run commands from this file; only run for interactive prompt
if ( -f "$HOME/Local/python-startup" ) then
	setenv PYTHONSTARTUP ~/Local/python-startup
endif

# This makes font looks non-ugly in Java applications
setenv _JAVA_OPTIONS "-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

# Special tricks for RVM
# https://stackoverflow.com/questions/27380203/how-do-i-use-rvm-with-tcsh
if (-d $HOME/.rvm/bin) setenv PATH ${PATH}:$HOME/.rvm/bin
if (-X rvm) then
	if ( ! $?ruby_version ) then
		set ruby_version = `grep RUBY_VERSION ~/.rvm/environments/default | cut -d= -f2 | tr -d \' | sed 's/^ruby-//'`
	endif

	setenv rvm_bin_path $HOME/.rvm/bin
	setenv GEM_HOME $HOME/.rvm/gems/ruby-$ruby_version
	setenv IRBRC $HOME/.rvm/rubies/ruby-$ruby_version/.irbrc
	setenv MY_RUBY_HOME $HOME/.rvm/rubies/ruby-$ruby_version
	setenv rvm_path $HOME/.rvm
	setenv rvm_prefix $HOME
	setenv PATH $HOME/.rvm/gems/ruby-$ruby_version/bin:$HOME/.rvm/gems/ruby-$ruby_version@global/bin:$HOME/.rvm/rubies/ruby-$ruby_version/bin:${PATH}:$HOME/.rvm/bin
	setenv GEM_PATH $HOME/.rvm/gems/ruby-${ruby_version}:$HOME/.rvm/gems/ruby-${ruby_version}@global
endif