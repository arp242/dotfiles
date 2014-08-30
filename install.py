#!/usr/bin/env python3
# encoding:utf-8
#

import os, subprocess, sys, shutil, sys

if sys.version_info.major < 3 or sys.version_info.minor < 3:
	print('Needs Python 3.3')
	sys.exit(1)


def usage():
	print("%s diff | merge | install" % sys.argv[0])


def runcmd(cmd):
	p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	return p.communicate()[0].decode()


def update():
	runcmd('hg up')


def diff(orig, new):
	return runcmd(r'diff -I\$hgid: -u %s %s' % (orig, new)).strip()


def istext(f):
	return runcmd('file "%s"' % f).split(':')[1].find('text') > -1


_version = '$hgid: %s' % (
	runcmd("hg parents --template '{node|short}'").replace('\n', ''))


if __name__ == '__main__':
	cwd = os.path.dirname(os.path.realpath(sys.argv[0]))
	cwdlen = len(cwd)
	update()

	if len(sys.argv) < 2:
		usage()
		sys.exit(0)
	else:
		cmd = sys.argv[1]
		if cmd not in ['diff', 'merge', 'install']:
			usage()
			sys.exit(1)

	for f in os.walk(cwd):
		dirname = f[0].replace(cwd, '')
		dirs = f[1]
		files = f[2]

		if dirname.startswith('/win32') and sys.platform != 'win32': continue
		if dirname[:4] == '/.hg': continue
		if dirname == '': dirname = '/'

		for f in files:
			if dirname == '/' and f == 'install.py': continue

			origfile = '%s/%s/%s' % (cwd, dirname, f)
			destfile = '%s/%s' % (dirname.replace('dot.', '.'), f.replace('dot.', '.'))
			destfile = os.path.expanduser(destfile.replace('/home/', '~/')).replace('//', '/')
			dif = diff(destfile, origfile)
			if cmd == 'diff':
				if os.path.exists(destfile):
					if dif != '': print(dif)
				else:
					print("==> %s doesn't exist" % destfile)
			elif cmd == 'merge':
				if os.path.exists(destfile) and dif != '':
					subprocess.call(['vimdiff', destfile, origfile])
			elif cmd == 'install' and dif.strip() != '':
				if os.path.exists(destfile):
					if not os.access(destfile, os.W_OK):
						print('==> %s not writable, skipping' % destfile)
						continue
					parent = destfile
					while not os.path.exists(parent):
						parent = os.path.dirname(destfile)
					if not os.access(destfile, os.W_OK):
						print("==> %s not writable, skipping %s" % (parent, destfile))
						continue

				print('Installing %s ' % (destfile), end='')
				if not os.path.exists(os.path.dirname(destfile)):
					os.makedirs(os.path.dirname(destfile))
				if os.path.islink(origfile):
					shutil.copy2(origfile, destfile, follow_symlinks=False)
				elif istext(origfile):
					try:
						data = open(origfile, 'r').read()
					# Not a UTF-8 file
					except UnicodeDecodeError:
						shutil.copy2(origfile, destfile)
						continue
					data = data.replace('$hgid:', _version)
					try:
						open(destfile, 'w').write(data)
					except IOError:
						print('Error: %s' % sys.exc_info()[1])
						continue
					shutil.copystat(origfile, destfile)
				else:
					shutil.copy2(origfile, destfile)
				print(' Okay')
