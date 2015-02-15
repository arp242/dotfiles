#!/usr/bin/env python
# encoding:utf-8
#
#

from __future__ import print_function
import glob, os, subprocess, re, sys, shutil

root = os.path.dirname(os.path.realpath(sys.argv[0]))


class Hg:
	def get_version_string(self, src):
		#return runcmd(['hg', 'parents', '--template', '{rev}', src])
		return runcmd(['hg', 'parents', '--template', '{rev}'])


	def file_is_modified(self, src, dest):
		data = open(dest, 'r').read()
		dotid = re.match('^.*?\$dotid: (.*)\$', data)
		if not dotid: return False
		dotid = dotid.groups()[0]

		data = data.replace('$dotid: {}$'.format(dotid), '$dotid$')
		orig_data = runcmd(['hg', 'cat', '--rev', dotid, src])

		return data == orig_data


vcs = Hg()

def runcmd(cmd):
	p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	return p.communicate()[0].decode()

def manage_dirs(dirs):
	# Ignore ./module.py
	# If file exists in dest but not in config -> Ask to copy
	# If file exists in config but not in dest -> copy
	# Run manage_files for rest
	#print(dirs)
	pass


def install_file(src, dest):
	print('{} -> {}'.format(src, dest))
	shutil.copy2(src, dest)

	data = open(dest, 'r').read()
	with open(dest, 'w') as fp:
		fp.write(data.replace('$dotid$', '$dotid: {}$'.format(vcs.get_version_string(src))))


def manage_files(files):
	"""
	If files are same -> do nothing
	If files differ, and installed copy is unmodified -> copy new
	If files differ, and installed copy is modified -> merge
	"""

	for dest, src in files.items():
		if not os.path.exists(dest):
			install_file(src, dest)
			continue

		# Check if the file is modified from the version string, if not, we can
		# just copy
		if not vcs.file_is_modified(src, dest):
			install_file(src, dest)
			continue

		# Don't diff files over 1MiB
		if os.stat(src).st_size > 1048576 or os.stat(dest).st_size > 1048576: continue

		# Check if files are the same; in which case a diff is useless
		h1 = hashlib.sha256(open(src, 'rb').read()).hexdigest()
		h2 = hashlib.sha256(open(dest, 'rb').read()).hexdigest()
		if h1 == h2: continue

		# Don't diff binary files
		if open(src, 'rb').read().find(b'\000') >= 0: continue

		# else manually merge
		subprocess.call(['vimdiff', dest, src])


def manage_symlinks(symlinks):
	# If link exist and point to something else -> ask
	# If link exists, and is not a file -> ask
	# Else -> make link
	for dest, link in symlinks.items():
		pass
		#if os.path.exists(link) and not os.path.islink(link):
		#	print("The link `{}' already exists and is not a symlink; skipping".format(link))
		#	continue

		#print(os.getcwd())
		#if os.path.exists(link) and os.lstat(link):
			#continue
		#print(link, ' -> ', dest)


def run_code(fun):
	#print(fun)
	pass


def expand_dict(d):
	""" Expand pathnames in key => value of a dict to full paths """
	e = lambda p: os.path.realpath(os.path.expanduser(p))
	return { e(k): e(v) for (k, v) in d.items() }


def proc_module(module, code):
	""" exec() module code, do something with it """
	assigns = {}
	exec(code, assigns)

	os.chdir(os.path.dirname(module))
	if assigns.get('files'): manage_files(expand_dict(assigns['files']))
	if assigns.get('dirs'): manage_dirs(expand_dict(assigns['dirs']))
	if assigns.get('symlinks'): manage_symlinks(expand_dict(assigns['symlinks']))
	if assigns.get('run'): run_code(assigns['run'])
	os.chdir(root)


if __name__ == '__main__':
	if len(sys.argv) > 1: modules = [ '{}/modules/{}/module.py'.format(root, m) for m in sys.argv[1:] ]
	else: modules = glob.glob(root + '/modules/*/module.py')

	for module in modules:
		with open(module, 'r') as fp: code = fp.read()
		proc_module(module, code)



'''
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
				# TODO: detect binary files
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
'''
