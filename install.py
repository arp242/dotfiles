#!/usr/bin/env python
#

import os
import subprocess
import sys

def GetVersion(self):
		cmd = "hg parents --template 'hgid: {node|short}'"

def RunCmd(cmd):
	return subprocess.call(cmd, shell=True)

def Update():
	RunCmd('hg up')

if __name__ == '__main__':
	cwd = os.path.dirname(os.path.realpath(sys.argv[0]))
	cwdlen = len(cwd)
	Update()

	for f in os.walk(cwd):
		dirname = f[0].replace(cwd, '')
		dirs = f[1]
		files = f[2]
		if dirname[:4] == '/.hg':
			continue

		if dirname == '':
			dirname = '/'

		print dirname
		print '\t', dirs
		print '\t', files
