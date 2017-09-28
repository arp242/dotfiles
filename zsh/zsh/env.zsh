# Setup PATH
typeset -U path  # No duplicates

# On Arch and some other systems some of these are links, so use the full path
# to prevent dupes.
_prepath() {
	local dir=$1
	[[ -L "$dir" ]] && dir=$(readlink -f "$dir")
	[[ ! -d "$dir" ]] && return
	path=("$dir" $path[@])
}
_postpath() {
	local dir=$1
	[[ -L "$dir" ]] && dir=$(readlink -f "$dir")
	[[ ! -d "$dir" ]] && return
	path=($path[@] "$dir")
}

_prepath /bin
_prepath /sbin
_prepath /usr/bin
_prepath /usr/sbin
_prepath /usr/games
_prepath /usr/pkg/bin    # NetBSD
_prepath /usr/pkg/sbin
_prepath /usr/X11R6/bin  # OpenBSD
_prepath /usr/X11R6/sbin
_prepath /usr/local/bin
_prepath /usr/local/sbin

# Ruby
_postpath "$HOME/.gem/ruby/2.1.0/bin"
_postpath "$HOME/.gem/ruby/2.2.0/bin"
_postpath "$HOME/.gem/ruby/2.3.0/bin"
_postpath "$HOME/.gem/ruby/2.4.0/bin"

# Go
_postpath "/usr/local/go/bin"
_postpath "/usr/local/gotools/bin"
_postpath "$HOME/go/bin"
_postpath "$HOME/work/bin"
_postpath "$HOME/work/martin-dev-env/bin"

_prepath "$HOME/Local/bin"

unfunction _prepath
unfunction _postpath

# Various applications settings
export GOPATH=$HOME/go:$HOME/work
export BLOCKSIZE=K
export PAGER=less
export LESS="--ignore-case --LONG-PROMPT --SILENT --no-init --no-lessopen"

# Make man pages 80 characters wide at the most; this is the default on BSD, but
# not Linux
export MANWIDTH=80

# Colors for ls(1)
export LS_COLORS="no=00:fi=00:di=34:ln=01;31:pi=34;43:so=31;43:bd=30;43:cd=30;43:or=01;35:ex=31:"

# Older GNU grep; BSD grep
export GREP_COLOR=31

# Newer GNU grep, I guess GREP_COLOR was too easy to use
export GREP_COLORS="ms=31:mc=31:sl=0:cx=0:fn=0:ln=0:bn=0:se=0"

# Fix scrolling in GTK3; https://www.pekwm.org/projects/pekwm/tasks/350
export GDK_CORE_DEVICE_EVENTS=1

# Make compose key work for GTK, Qt
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# Disable retarded "overlay scrollbar"
export GTK_OVERLAY_SCROLLING=0

# Don't output to a pager
export SYSTEMD_PAGER

# Setup pass
export PASSWORD_STORE_DIR=/data/stuff/password-store
export PASSWORD_STORE_X_SELECTION=primary
export PASSWORD_STORE_CLIP_TIME=10
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# Do the $TERM dance; these options seem to work best on various systems...
if [[ -n "$TMUX" ]]; then
	export TERM=screen-256color
elif [[ $uname = OpenBSD ]]; then
	export TERM=xterm-xfree86
elif [[ $uname = FreeBSD ]]; then
	if  [[ $tty =~ ttyv* ]]; then
		export TERM=cons25
	else
		export TERM=xterm-256color
	fi
elif [[ $uname == Linux ]]; then
	export TERM=xterm-256color
	#setenv TERM xterm-color
else
	export TERM=vt220
fi

# UTF-8
if _exists locale; then
	export LANG=en_US.UTF-8
	export LC_CTYPE=en_US.UTF-8
	export LC_COLLATE=en_US.UTF-8
	#export I18NPATH=~/.locale
	#export LOCPATH=~/.locale
fi

# Set editor
if _exists vim; then
	export EDITOR=vim
	alias vim="vim -p"
	alias vi="vim"
elif _exists vi; then
	export EDITOR=vi
fi

_exists firefox && export BROWSER=firefox

## Set DISPLAY on remote login
#if ($?REMOTEHOST && ! $?DISPLAY) then 
#	export DISPLAY=${REMOTEHOST}:0
#fi

# Run commands from this file; only run for interactive prompt
[[ -f "$HOME/Local/python-startup" ]] && export PYTHONSTARTUP=~/Local/python-startup

# This makes font looks non-ugly in Java applications
export _JAVA_OPTIONS="-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
