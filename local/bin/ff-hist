#!/bin/sh
#
# https://github.com/arp242/ff-hist; see bottom of the file for copyright.
#
# Usage:
# 
#     $ ff-hist term
# 
# This will search for the term in the URL and title as 'like %..%'.
# 
# To limit to just the URL or title, prefix with url: or title:
# 
#     $ ff-hist title:term
# 
# You can add multiple, which are AND'd together:
# 
#     $ ff-hist term title:other
# 
# To OR together, add "or:"
# 
#       $ ff-hist title:term url:or:reddit.com or:asd
# 
# The output is aligned in columns to fit the window; add -full to always
# dispaly everything.
# 
# Use -show to echo the SQL query before running, or -showonly to just show the
# URL and exit.
# 
# You can get the full URL by giving the ID (first column in output):
# 
#       $ ff-hist 42
#       $ ff-hist 42,666
#       $ ff-hist 42 666   # Identical
# 
# All the parameter can also be passed from stdin if the first argument is `-`;
# parameters are separated by newlines.
# 
# You can pipe this to `fzf` or `dmenu` or whatever if you wish:
# 
#     $ ff-hist hello | dmenu | cut -d' ' -f1 | ff-hist - | xclip -rmlastnl -selection clipboard
#

set -eu

places=${PLACES:-}
[ -z "$places" ] && places=$(ls $HOME/.mozilla/firefox/*.default/places.sqlite)
if [ ! -f "$places" ]; then
	echo >&2 'places.sqlite not found; set $PLACES:'
	echo >&2 "    PLACES=/firefox_profile/places.sqlite $0"
	exit 1
fi

tmp="/tmp/places.sqlite"

# Need to copy the database as Firefox locks it while running; can't really
# figure out a better way to do this.
copy_db() {
	trap "rm $tmp" EXIT
	cp "$places" "$tmp"
}

args=
for f in "$@"; do
	args="$args$f
"
done

if [ "${1:-}" = "-" ]; then
	shift
	args="$args
$(cat -)"
fi

IFS="
"

# Find URLs by ID.
if echo "$args" | grep -q '^[0-9,]\+$'; then
	n=$(echo "$args" | tr ' ' ,)
    query="select url from moz_places where id in ($n)"

	copy_db
    sqlite3 -init /dev/null -noheader -batch -list "$tmp" "$query" 2>&1
    exit 0
fi


# Search by url/title, or show everything.
where=""
add_col() {
	local col=$1
	local term="$2"
	local op="and"
	if echo "$term" | grep -q '^or:'; then
		op=or
		term="${term#or:}"
	fi

	if [ -z "$where" ]; then
		where="where $col like '%$term%'"
	else
		where="$where $op $col like '%$term%'"
	fi
}
full=0
show=0
for arg in $args; do
	case "$arg" in 
		[\-]*full)     full=1 ;;
		[\-]*showonly) show=2 ;;
		[\-]*show)     show=1 ;;
		title:*)   add_col 'title' "${arg#title:}" ;;
		url:*)     add_col 'url' "${arg#url:}"     ;;
		*)
			add_col 'title' "$arg"
			add_col 'url'   "$arg"
	esac
done

if [ $full ]; then
	width=".width 0 0 0 0"
else
	w=$(( ($(tput cols) - 28) / 2))
	width=".width 6 16 $w $w"
fi

query="select
    id,
    strftime('%Y-%m-%d %H:%M', datetime(substr(last_visit_date, 0, 11), 'unixepoch')) as last_visit,
    title,
    replace(replace(url, 'https://', ''), 'http://', '') as url
from moz_places
$where
order by last_visit_date desc"
[ $show -gt 0 ] && (echo "$query"; echo)
[ $show -gt 1 ] && exit 0

copy_db
sqlite3 -init /dev/null -noheader -batch -column -cmd "$width" "$tmp" "$query" 2>&1


# The MIT License (MIT)
#
# Copyright © 2020 Martin Tournoij
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# The software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising
# from, out of or in connection with the software or the use or other dealings
# in the software.
