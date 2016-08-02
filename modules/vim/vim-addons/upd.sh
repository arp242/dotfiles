for f in ./*; do
	[ ! -d "$f" ] && continue


	cd "$f"

	if [ -d .git ]; then
		git pull > /dev/null
		git gc --aggressive --prune > /dev/null
	fi

	cd ..
done
