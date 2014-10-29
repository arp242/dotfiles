# Update xterm title & git/hg branch on directory change (special alias)
if ( $uname != win32 && -f ~/.tcsh/cwdcmd.tcsh ) then
	alias cwdcmd source ~/.tcsh/cwdcmd.tcsh
else
	unalias cwdcmd
endif

# What to run on F1
alias helpcommand man

if ($uname == FreeBSD) then
	alias ls "ls-F -I"
	alias la "ls-F -A"
	alias lc "ls-F -lThoI"
	alias lac "ls-F -lThoA"
	alias pdiff "diff -urN -x CVS -x .svn -I '^# .FreeBSD: '"

	# bsdgrep is FreeBSD >=9
	# bsdgrep doesn't seem stable/reliable (yet)
	#if (-X bsdgrep) then
	#	alias grep "bsdgrep --color"
	#else
		alias grep "grep --color"
	#endif
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

	alias pdiff "diff -urN -x CVS -x .svn -I '^# .OpenBSD: '"
else if ($uname == SunOS) then
	alias ls "ls-F"
	alias la "/bin/ls -FA"
	alias lc "/bin/ls -Flho"
	alias lac "/bin/ls -FlAho"
else if ($uname == Linux) then
	unalias ls

	alias ls 'ls-F'
	alias lc ls -lh
	alias la ls -A
	alias lac ls -lhA
	alias grep "grep --color"

	alias sockstat "netstat -lnptu --protocol=inet,unix"
	alias zzz 'pm-hibernate'

	# bsdtar/libarchive works with many file formats, not just tar
	if (-X bsdtar) alias tar bsdtar

	# TODO: I'm not sure if all Linux systems use the same cal flavour?
	alias cal 'cal -m3'
else if ($uname == win32) then
	alias ls ls-F
	alias la "ls -a"
	alias lc "ls -l"
	alias lac "ls -la"

	alias clear cls
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
if (-x /usr/bin/time) alias time "/usr/bin/time -h"

# A few more aliases...
alias cp "cp -i"
alias mv "mv -i"
alias make "nice -n 20 make"
alias j "jobs -l"
alias lman "groff -man -Tascii" # `local man' <file>.1

# Third-party stuff
if (-X mplayer) alias music "mplayer -cache-min 0 $* *.{mp3,flac}"
if (-X opera) alias opera "opera -nomail"

if (-X curl) then
	alias curl-post 'curl -X POST'
	alias curl-put 'curl -X PUT'
	alias curl-delete 'curl -X DELETE'
endif

alias dejson 'python -mjson.tool'
alias ag 'ag -S --color-match 31 --color-line-number 35 --color-path 1\;4'

# Use title in filename
alias youtube-dl 'youtube-dl --no-part -t'


# Typos
alias sl "ls"
alias l "ls"
alias c "cd"
alias vo "vi"
alias ci "vi" # ci already exists, but few people use it and it mangles files!
alias grpe "grep"
alias Grep "grep"
alias les less


# Visual separator
alias sep "echo '\033[1;34m=========================================\033[0m'"

# http://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream#380778
# man Term::ANSIColor 
# http://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
# http://www.andrewnoske.com/wiki/Unix_-_ANSI_colors
alias decolor "sed 's|\x1b\[[;0-9]*m||g'"
alias trcolor "sed -e 's|\x1b\[36m|\x1b\[31m|g'; 's|\x1b\[33m|\x1b\[31m|g'"

if (-X cmst) then
	alias connman-qt cmst
endif

# TODO: This doesn't work...
# http://po-ru.com/diary/using-rvm-with-tcsh/
if (-X "$HOME/.rvm/scripts/rvm") then
	alias rvm rvm.tcsh
	alias rvm-rake 'rvm all do rake'
	alias rvm-ruby 'rvm all do ruby'

	setenv PATH ${PATH}:$HOME/.rvm/gems/ruby-2.1.1/bin:$HOME/.rvm/gems/ruby-2.1.1@global/bin:$HOME/.rvm/rubies/ruby-2.1.1/bin:$HOME/.rvm/bin/ 
endif

# Until I can find/make a colour scheme that works
alias ipython 'ipython --colors=NoColor --no-confirm-exit'
