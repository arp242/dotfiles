#!/usr/bin/env python
#

import os
import subprocess
import sys

def RunCmd(cmd):
	p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	return p.communicate()[0]

def GetVersion(self):
	return RunCmd("hg parents --template 'hgid: {node|short}'").split(':')[1].strip()

def Update():
	RunCmd('hg up')

def Diff(orig, new):
	return RunCmd('diff -u %s %s' % (orig, new))

if __name__ == '__main__':
	cwd = os.path.dirname(os.path.realpath(sys.argv[0]))
	cwdlen = len(cwd)
	Update()

	if len(sys.argv) < 2:
		cmd = 'diff'
	else:
		cmd = sys.argv[1]

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
			destfile = os.path.expanduser(destfile.replace('/home/', '~/')).replace('//', '/')
			diff = Diff(destfile, origfile)
			if cmd == 'diff':
				if os.path.exists(destfile):
					print diff,
				else:
					print "===> %s doesn't exist" % destfile
			elif cmd == 'install' and diff.strip() != '':
				print 'Installing %s' % (destfile)

				# TODO: mkdir
				# TODO: backup
				# TODO: Copy file
