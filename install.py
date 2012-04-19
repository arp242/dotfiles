#!/usr/bin/env python
#

import os
import subprocess
import sys

def GetVersion(self):
		cmd = "hg parents --template 'hgid: {node|short}'"

def RunCmd(cmd):
	p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	output = p.communicate()[0]

	return output

def Update():
	RunCmd('hg up')

def Diff(orig, new):
	return RunCmd('diff -u %s %s' % (orig, new))

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

		for f in files:
			if dirname == '/' and f == 'install.py':
				continue

			origfile = '%s/%s/%s' % (cwd, dirname, f)
			destfile = '%s/%s' % (dirname.replace('dot.', '.'), f.replace('dot.', '.'))
			if not os.path.exists(destfile):
				pass
				#print '%s doesn\'t exists' % destfile
			else:
				print destfile
				print Diff(destfile, origfile)
