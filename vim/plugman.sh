# $dotid$
#
#!/bin/sh

. ./plugman.conf

set -euC
IFS="
"
cd "$install_dir"

_usage() {
	echo "$0 [mode]"
	echo
	echo "mode can be:"
	echo "    versions    Show last commit for all installed plugins"
	echo "    install     Install new plugins; don't update existing"
	echo "    update      Update existing plugins; don't update new"
	echo
	echo "If no mode is given we will install new plugins and update existing"
	echo
}

mode=""
if [ -n "${1:-}" ]; then
	case "$1" in
		versions) mode=versions ;;
		install)  mode=install ;;
		update)   mode=update ;;
		*)        _usage; exit 1 ;;
	esac
fi

# Show versions
if [ "$mode" = "versions" ]; then
	for repo in $want; do
		repo=$(echo "$repo" | tr -d ' ')
		dirname=$(echo "$repo" | cut -d/ -f2)
		
		printf "%-30s %s" "$repo"

		if [ ! -e "$dirname" ]; then
			echo "Not installed"
		else
			(
				cd "$dirname"
				git log -n1 --date=short --format='%h %ad %s'
			)
		fi
	done
	exit 0
fi

# Default is to install or update
total=$(( $(echo "$want" | wc -l) - 2 ))
i=0
for repo in $want; do
	i=$(($i + 1))
	repo=$(echo "$repo" | tr -d ' ')
	dirname=$(echo "$repo" | cut -d/ -f2)
	printf "\r\033[0K($i/$total) "

	# Update existing
	if [ -e "$dirname" ]; then
		[ "$mode" = "install" ] && continue
		printf "updating '$dirname' from '$repo'"
		(
			cd "$dirname"
			git pull --quiet
		)
	# Install new
	else
		[ "$mode" = "update" ] && continue
		printf "cloning '$repo' to '$dirname'"
		git clone --quiet "git@github.com:$repo" "$dirname"
	fi
done
