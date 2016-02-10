# $logid$

set noglob

set hosts
if ( -r "$HOME/.hosts" ) then
	set hosts=($hosts `grep -Ev '(^#|^$)' $HOME/.hosts`)
endif

if ( -r "$HOME/.ssh/config" ) then
	set hosts=($hosts `grep ^Host $HOME/.ssh/config | cut -d' ' -f2`)
endif

if ( -r "$HOME/.ssh/known_hosts" ) then
	set hosts=($hosts `cut -d' ' -f 1 $HOME/.ssh/known_hosts | cut -d, -f1`)
endif

set hosts = `echo "$hosts" | tr -d '[]' | tr ' ' '\012' | sort -u`

# From src/tcsh/complete.tcsh
# set hosts=(`echo $hosts | tr ' ' '\012' | sort -u`)

# Show directories only
complete cd 'C/*/d/'
complete rmdir 'C/*/d/'

# Various built-in
complete alias 'p/1/a/'
complete unalias 'p/1/a/'
complete unset 'p/1/s/'
complete set 'p/1/s/'
complete unsetenv 'p/1/e/'
complete setenv 'p/1/e/'
complete limit 'p/1/l/'
complete bindkey 'C/*/b/'
complete uncomplete 'p/*/X/'
complete fg 'c/%/j/'

# Users
complete chgrp 'p/1/g/'
complete chown 'c/*[.:]/g/' 'p/1/u/:' 'n/*/f/'

# Procs
complete kill 'c/-/S/' 'n/*/`ps axco pid= | sort`/'
complete pkill 'c/-/S/' 'n/*/`ps axco command= | sort -u`/'
complete killall 'c/-/S/' 'n/*/`ps axco command= | sort -u`/'

# Use available commands as arguments
complete which 'p/1/c/'
complete where 'p/1/c/'
complete man 'p/1/c/'
complete apropos 'p/1/c/'

# set up programs to complete only with files ending in certain extensions
complete cc 'p/*/f:*.[cao]/'
#complete python 'p/*/f:*.py/'
#complete perl 'p/*/f:*.[pP][lL]/'

# Complete hosts
complete ssh 'p/1/$hosts/'
complete pssh 'p/1/$hosts/'
complete sftp 'p/1/$hosts/'
complete ftp 'p/1/$hosts/'
complete scp 'p/1/$hosts/'
complete ping 'p/1/$hosts/'

# Misc.
complete hg 'p/1/(add addremove annotate archive backout bisect bookmarks \
	branch branches bundle cat clone commit copy diff export forget graft \
	grep heads help identify import incoming init locate log manifest \
	merge outgoing parents paths phase pull push recover remove rename \
	resolve revert rollback root serve showconfig status summary tag tags \
	tip unbundle update verify version)/'

complete svn 'p/1/(add blame cat changelist checkout cleanup commit copy \
	delete diff export help import info list lock log merge mergeinfo \
	mkdir move propdel propedit propget proplist propset resolve \
	resolved revert status switch unlock update)/' \
	'n/help/(add blame cat changelist checkout cleanup commit copy \
	delete diff export help import info list lock log merge mergeinfo \
	mkdir move propdel propedit propget proplist propset resolve \
	resolved revert status switch unlock update)/'

complete git 'p/1/(add merge-recursive add--interactive merge-resolve am \
	merge-subtree annotate merge-tree apply mergetool archimport mktag \
	archive mktree bisect mv bisect--helper name-rev blame notes branch \
	pack-objects bundle pack-redundant cat-file pack-refs check-attr \
	patch-id check-ref-format peek-remote checkout prune checkout-index \
	prune-packed cherry pull cherry-pick push clean quiltimport clone \
	read-tree column rebase commit receive-pack commit-tree reflog config \
	relink count-objects remote credential-cache remote-ext \
	credential-cache--daemon remote-fd credential-store remote-ftp daemon \
	remote-ftps describe remote-http diff remote-https diff-files \
	remote-testgit diff-index repack diff-tree replace difftool \
	repo-config difftool--helper request-pull fast-export rerere \
	fast-import reset fetch rev-list fetch-pack rev-parse filter-branch \
	revert fmt-merge-msg rm for-each-ref send-email format-patch send-pack \
	fsck sh-i18n--envsubst fsck-objects shell gc shortlog \
	get-tar-commit-id show grep show-branch hash-object show-index help \
	show-ref http-backend stage http-fetch stash http-push status \
	imap-send stripspace index-pack submodule init symbolic-ref init-db \
	tag instaweb tar-tree log unpack-file lost-found unpack-objects \
	ls-files update-index ls-remote update-ref ls-tree update-server-info \
	mailinfo upload-archive mailsplit upload-pack merge var merge-base \
	verify-pack merge-file verify-tag merge-index web--browse \
	merge-octopus whatchanged merge-one-file write-tree merge-ours)/' \
	'n@checkout@`git branch -a | sed -r "s|^[\* ]+(remotes/origin/)?||; /^HEAD/d" | sort -u`@' \
	'n@co@`git branch -a | sed -r "s|^[\* ]+(remotes/origin/)?||; /^HEAD/d" | sort -u`@' \
	'n@branch@`git branch -a | sed -r "s|^[\* ]+(remotes/origin/)?||; /^HEAD/d" | sort -u`@'

complete find 'n/-fstype/"(nfs 4.2)"/' 'n/-name/f/' \
	'n/-type/(c b d f p l s)/' \
	'n/-user/u/ n/-group/g/' \
	'n/-exec/c/' 'n/-ok/c/' \
	'n/-cpio/f/' \
	'n/-ncpio/f/' \
	'n/-newer/f/' \
	'c/-/(fstype name perm prune type user nouser group nogroup size inum \
		atime mtime ctime exec ok print ls cpio ncpio newer xdev depth \
		daystart follow maxdepth mindepth noleaf version anewer cnewer \
		amin cmin mmin true false uid gid ilname iname ipath iregex \
		links lname empty path regex used xtype fprint fprint0 fprintf \
		print0 printf not a and o or)/' \
	'n/*/d/'

# pmake & GNU make
if ( $uname == FreeBSD ) then
	set backslash_quote
	complete gmake 'n@*@`make -qp | awk -F: \'/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ { split($1,A,/ /); for(i in A)print A[i] }\' | sort -u`@'
	unset backslash_quote

	if ( `uname -r | cut -d. -f1` < 10 ) then
		complete make 'n@*@`make -pn | sed -n -E "/^[#_.\/[:blank:]]+/d; /=/d; s/[[:blank:]]*:.*//gp;"`@'
	else
		complete make 'n/*/`make -V .ALLTARGETS`/'
	endif
else if ( $uname == Linux ) then
	set backslash_quote
	complete make 'n@*@`make -qp | awk -F: \'/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ { split($1,A,/ /); for(i in A)print A[i] }\' | sort -u`@'
	unset backslash_quote
endif

complete dd 'c/if=/f/' 'c/of=/f/' \
	'c/conv=*,/(ascii block ebcdic lcase pareven noerror notrunc osync sparse swab sync unblock)/,' \
	'c/conv=/(ascii block ebcdic lcase pareven noerror notrunc osync sparse swab sync unblock)/,' \
	'p/*/(bs cbs count files fillcahr ibs if iseek obs of oseek seek skip conv)/='

# FreeBSD-specific stuff
if ($uname == FreeBSD) then
	complete service 'p/1/`service -l`/' 'n/*/(start stop reload restart status rcvar onestart onestop)/'
	complete ifconfig 'p/1/`ifconfig -l`/'
	complete sysctl 'n/*/`sysctl -Na`/'

	complete pkg_delete 'n@*@`/bin/ls /var/db/pkg`@'
	complete pkg_info 'n@*@`/bin/ls /var/db/pkg`@'
	complete kldload 'n@*@`/bin/ls -1 /boot/modules/ /boot/kernel/ | grep -v symbols | sed "s|\.ko||g"`@'
	complete kldunload 'n@*@`kldstat | awk \{sub\(\/\.ko\/,\"\",\$NF\)\;print\ \$NF\} | grep -v Name`@'
	complete netstat 'n/-I/`ifconfig -l`/' 'n/*/(start stop restart reload status)/'
# Linux
else if  ($uname == Linux) then
	complete service 'p@1@`/bin/ls /etc/init.d`@'
	complete ifconfig 'p/1/`ifconfig -a -s | sed 1d | cut -d" " -f1`/'
	complete sysctl 'n/*/`sysctl -N -a`/'

	complete chkconfig 'c/--/(list add del)/' 'n@*@`/bin/ls /etc/init.d`@'

	complete systemctl 'p@*@`systemctl list-units --all -t service,timer,socket,mount,automount,path,snapshot,swap --no-legend | cut -d\  -f1`@'
endif

unset noglob
