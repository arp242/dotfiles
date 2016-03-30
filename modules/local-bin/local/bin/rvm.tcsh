#!/usr/bin/env tcsh
# $dotid$
#
# http://po-ru.com/diary/using-rvm-with-tcsh/

# /bin/sh will not work!

set rvm_command="source ${HOME}/.rvm/scripts/rvm; rvm $*"
if ($1 == "use") then
	bash -c "$rvm_command && tcsh"
else
	bash -c "$rvm_command"
endif

