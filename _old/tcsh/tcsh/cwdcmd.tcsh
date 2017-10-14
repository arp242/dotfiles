# vim:set syntax=tcsh

# Show the directory in the xterm title
echo -n "\033]2;tcsh: $cwd\007"

# Setup GOPATH
#setenv GOPATH

# Show git branch in prompt
unset printexitvalue
git rev-parse --abbrev-ref HEAD >& /dev/null
if ( $? == 0 ) then
	set branch = "`git rev-parse --abbrev-ref HEAD`"
# We're not in a repo
else
	unset branch
endif
set printexitvalue

# Set prompt
set promptchars = "%#"
set prompt = "[%~]"
if ( $?branch ) then 
	set prompt = "$prompt($branch)"
endif
set prompt = "$prompt%# "

# Blue prompt if we're in a sandbox
#if ( ${?SANDBOX} == 1 ) then
#	set blue = "%{\033[34m%}"
#	set end = "%{\033[0m%}"
#	set prompt = "[%~]${blue}%#${end} "
#endif
