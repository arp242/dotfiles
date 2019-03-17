# Setup PATH
typeset -U path  # No duplicates

# On Arch and some other systems some of these are links, so use the full path
# to prevent dupes.
_prepath() {
	for dir in "$@"; do
		[[ -L "$dir" ]] && dir=$(readlink -f "$dir")
		[[ ! -d "$dir" ]] && return
		path=("$dir" $path[@])
	done
}
_postpath() {
	for dir in "$@"; do
		[[ -L "$dir" ]] && dir=$(readlink -f "$dir")
		[[ ! -d "$dir" ]] && return
		path=($path[@] "$dir")
	done
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

_postpath $HOME/.gem/ruby/*/bin        # Ruby
_prepath "$HOME/go/bin"                # Go
_postpath "$HOME/.vim/pack/plugins/start/gopher.vim/tools/bin"
_prepath "$HOME/.local/bin"            # My local stuff.

unfunction _prepath
unfunction _postpath

# Store Go tmp files in /tmp; make sure it exists, as Go won't create it for us
# and error out!
export GOTMPDIR=/tmp/gotmpdir
[[ ! -d "$GOTMPDIR" ]] && mkdir "$GOTMPDIR"

# Various applications settings
export BLOCKSIZE=K
export PAGER=less
export LESS="--ignore-case --LONG-PROMPT --SILENT --no-init --no-lessopen"

# Make man pages 80 characters wide at the most; this is the default on BSD, but
# not Linux (not needed if you use mandoc, instead of the man-db crap).
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

# Disable stupid "overlay scrollbar"
export GTK_OVERLAY_SCROLLING=0

# Don't output to a pager
export SYSTEMD_PAGER=

# Set user service dir for runit.
[[ $uid -gt 0 ]] && export SVDIR=~/.config/service

# Setup pass
export PASSWORD_STORE_DIR=/home/martin/.config/password-store
export PASSWORD_STORE_X_SELECTION=primary
export PASSWORD_STORE_CLIP_TIME=10
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# Set TERM.
[[ -n "$TMUX" ]] && export TERM=screen-256color || export TERM=st-256color

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
elif _exists vi; then
	export EDITOR=vi
fi

_exists firefox && export BROWSER=firefox

## Set DISPLAY on remote login
#if ($?REMOTEHOST && ! $?DISPLAY) then
#	export DISPLAY=${REMOTEHOST}:0
#fi

# Run commands from this file; only run for interactive prompt
[[ -f "$HOME/.local/python-startup" ]] && export PYTHONSTARTUP=~/.local/python-startup

# Makes it easier to write configs specific to just my laptop.
#export HOSTNAME=$(hostname)

# This makes font looks non-ugly in Java applications
#export _JAVA_OPTIONS="-Dswing.aatext=true -Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/opt/android-studio/jre
