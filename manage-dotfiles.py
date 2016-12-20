#!/usr/bin/env python3
# encoding:utf-8
#
# TODO: Give module.py the ability to add more ignore patterns
#

import hashlib, glob, os, pprint, tempfile, subprocess, re, sys, shutil, time

if sys.version_info[0] < 3:
	print('Needs Python 3')
	sys.exit(2)

if sys.argv[0] in ['', '-']: sys.argv[0] = 'stdin'
root = os.path.dirname(os.path.realpath(sys.argv[0]))

# TODO: These should all be commandline arguments
verbose = True
difftool = ['vimdiff', '-c source {}/diffexpr.vim'.format(root)]
clobber_it_all = False


### Various helpers
def dbg(msg):
	if verbose: print(msg)


def install_file(src, dest):
	""" Install (copy) the 'src' file to the 'dest'. Do sane things on
	unexpected cases (such as 'dest' being a symlink). """

	# The destination is a symlink, this is rather unexpected
	# TODO: Ask what to do
	if os.path.islink(dest):
		print("`{} is a symlink".format(dest))
		return

	# Make dirs if required
	if not os.path.exists(os.path.dirname(dest)):
		os.makedirs(os.path.dirname(dest))

	# Check for write access
	if os.path.exists(dest) and not os.access(dest, os.W_OK):
		print("`{}' not writable; skipping".format(dest))
		return

	# Copy!
	dbg('{} -> {}'.format(src, dest))
	shutil.copy2(src, dest)
	add_version(src, dest)


def add_version(src, dest):
	""" Add version string """
	data = open(dest, 'rb').read()
	with open(dest, 'wb') as fp:
		fp.write(data.replace(b'$dotid$',
			bytes('$dotid: {}$'.format(vcs.get_version_string(src)), 'utf-8')))


def runcmd(cmd):
	p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
	return p.communicate()[0].decode()


def ask(question, options=['y', 'n'], default=None):
	if default is None: default = options[0]
	opt_str = '/'.join([ o.upper() if o == default else o for o in options ])
	answer = input('{} [{}]? '.format(question, opt_str)).strip().lower()

	if answer == '': return default
	if answer in options: return answer
	elif len(answer) == 1:
		for o in options:
			if o == answer or o[0] == answer[0]: return o
	return ask(question, options, default)


def expand_dict(d):
	""" Expand pathnames in key => value of a dict to full paths """
	# TODO: os.path.normpath?
	e = lambda p: os.path.realpath(os.path.expanduser(p))
	return { e(k): e(v) for (k, v) in d.items() }


### VCS
class Hg:
	def get_version_string(self, src):
		s = runcmd(['hg', 'parents', '--template', '{rev}', src])
		if s.startswith('abort'): return ''
		else: return s


	def file_is_modified(self, src, dest):
		'''
		Returns an int:
		0: File is not modified (False)
		1: File is modified (True)
		2: File is not modified and exactly the same version (False)

		if src is unknown to the VCS, return 1 (so we merge, safest option)
		'''
		try:
			data = open(dest, 'r').read()
		except Exception as e:
			print('Unable to open {}'.format(dest))
			raise e

		dotid = re.match('^.*?\$dotid: (.*)\$', data)
		if not dotid: return 1

		dotid = dotid.groups()[0]

		if dotid == self.get_version_string(src): return 2

		data = data.replace('$dotid: {}$'.format(dotid), '$dotid$')
		orig_data = runcmd(['hg', 'cat', '--rev', dotid, src])

		return int(data != orig_data)

class Date:
	def get_version_string(self, src):
		return str(int(time.time()))

	def file_is_modified(self, src, dest):
		return 1

if False:
	vcs = Hg()
else:
	vcs = Date()


### Main


def manage_dirs(dirs):
	mp = lambda a, b: '{}/{}'.format(a, b)

	for dest, src in dirs.items():
		# Destination exsists, but isn't a directory!
		if os.path.exists(dest) and not os.path.isdir(dest):
			print("Warning: `{}' exists, but is not a directory".format(dest))
			action = ask('What shall we do', ['ignore', 'remove'])
			if action == 'ignore': continue
			if action == 'remove': os.unlink(dest) # TODO: What if dest is a dir?

		# mkdir -p if required
		if not os.path.exists(dest): os.makedirs(dest)

		# Get list of all files we want to install and run manage_files() on that
		for src_root, _, srcfiles in os.walk(src):
			dest_root = src_root.replace(src, dest)
			#srcfiles = { mp(dest, f): mp(src, f) for f in srcfiles if f != 'module.py' }
			srcfiles = { mp(dest_root, f): mp(src_root, f) for f in srcfiles if f != 'module.py' }
			manage_files(srcfiles)

		# Get a list of files in the destination that's *not* already in the
		# source and ask what we want to do with these files
		for root, _, destfiles in os.walk(dest):
			# TODO: Doesn't seem to work? (module vim)
			continue
			for f in destfiles:
				full_f = mp(dest, f)
				if full_f in srcfiles.keys(): continue

				# TODO: Make sure dirs end with /
				# TODO: Ass option "view" and/or "manual merge"
				print("The file `{}' exists in `{}', but is not in `{}'".format(
					f, dest, src))
				action = ask('What shall we do', ['ignore', 'remove', 'copy'])
				if action == 'ignore': continue
				if action == 'remove': os.unlink(full_f)
				if action == 'copy': shutil.copy2(full_f, mp(src, f))



def manage_files(files):
	for dest, src in files.items():
		# User asked to clobber it all
		if clobber_it_all:
			install_file(src, dest)
			continue

		# src is a binary file (we don't check dest); don't do anything
		# TODO: ask what to do where
		if os.path.exists(src):
			with open(src, 'rb') as fp:
				is_binary = False
				try:
					with open(dest, 'r') as testfp:
						testfp.read()
				except UnicodeDecodeError:
					is_binary = True

				if is_binary or b'\x00' in fp.read(2048) and os.path.exists(dest):
					h1 = hashlib.sha256(open(src, 'rb').read()).hexdigest()
					h2 = hashlib.sha256(open(dest, 'rb').read()).hexdigest()
					if h1 != h2:
						print("`{}' is modified but looks like a binary file; skipping".format(src))
					continue

		# Files are same dotid, and not changes: we do nothing
		if os.path.exists(src) and vcs.file_is_modified == 2:
			continue
			mod = vcs.file_is_modified(src, dest)
			if vcs.file_is_modified == 2: continue

		# File doesn't exist or unmodified since version string -> install
		if not os.path.exists(dest) or vcs.file_is_modified(src, dest) == 0:
			install_file(src, dest)
			continue

		# Larger than 1 MiB -> don't manually merge
		if os.stat(src).st_size > 1048576 or os.stat(dest).st_size > 1048576:
			print("Skipping merge of `{}' because it is larger than 1MiB".format(src))
			continue

		# Check again if the files differ, but this time ignoring lines with
		# $dotignore$; this test is comparatively slow, which is why we do it
		# here
		dest_data = [ l for l in open(dest, 'r').readlines() if not ('$dotignore$' in l or '$dotid' in l)]
		src_data = [ l for l in open(src, 'r').readlines() if not ('$dotignore$' in l or '$dotid' in l) ]
		if src_data == dest_data: continue

		run_diff(src, dest)


def run_diff(src, dest):
	subprocess.call(difftool + [dest, src])
	add_version(src, dest)

	# I don't like this solution because we're editing a temp file...
	'''
	with tempfile.NamedTemporaryFile(mode='w', prefix='manage-dotfiles_') as fp:
		data = open(dest, 'r').read()
		dotid = re.match('^.*?\$dotid: (.*)\$', data)
		if dotid:
			dotid = dotid.groups()[0]
			data = data.replace('$dotid: {}$'.format(dotid), '$dotid$')
		data = [ l for l in data.split('\n') if l.find('$dotignore$') == -1 ]
		fp.write('\n'.join(data))
		fp.flush()

		subprocess.call([difftool, fp.name, src])
	'''


def manage_symlinks(symlinks):
	# TODO
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


def proc_module(module, code):
	""" exec() module code, do something with it """
	assigns = {}
	exec(code, assigns)

	os.chdir(os.path.dirname(module))
	if assigns.get('files'): manage_files(expand_dict(assigns['files']))
	if assigns.get('dirs'): manage_dirs(expand_dict(assigns['dirs']))
	if assigns.get('symlinks'): manage_symlinks(expand_dict(assigns['symlinks']))
	if assigns.get('run'):
		try:
			assigns['run']()
		except:
			print('Error in:', module)
			raise
	os.chdir(root)


if __name__ == '__main__':
	if 'CLOBBER_IT_ALL' in sys.argv:
		clobber_it_all = True
		sys.argv.remove('CLOBBER_IT_ALL')

	if len(sys.argv) > 1: modules = [ '{}/modules/{}/module.py'.format(root, m) for m in sys.argv[1:] ]
	else: modules = glob.glob(root + '/modules/*/module.py')

	try:
		for module in modules:
			try:
				with open(module, 'r') as fp: code = fp.read()
			except FileNotFoundError:
				print("Module `{}' doesn't exist".format(module))
				sys.exit(1)

			proc_module(module, code)
	except KeyboardInterrupt:
		print()
		sys.exit(0)
