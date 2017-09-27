#!/usr/bin/env python3
# encoding:utf-8
#

import glob
import hashlib
import os
import pprint
import re
import shutil
import subprocess
import sys
import tempfile
import time


if sys.version_info[0] < 3:
    print('Needs Python 3')
    sys.exit(2)

if sys.argv[0] in ['', '-']:
    sys.argv[0] = 'stdin'
root = os.path.dirname(os.path.realpath(sys.argv[0]))

# TODO: These should all be commandline arguments
verbose = True
difftool = ['vimdiff', '-c source {}/diffexpr.vim'.format(root)]
clobber_it_all = False


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
            if o == answer or o[0] == answer[0]:
                return o
    return ask(question, options, default)


def expand_dict(d):
    """ Expand pathnames in key => value of a dict to full paths """
    # TODO: os.path.normpath?
    e = lambda p: os.path.realpath(os.path.expanduser(p))
    return { e(k): e(v) for (k, v) in d.items() }


def manage_dirs(dirs):
    mp = lambda a, b: '{}/{}'.format(a, b)

    for dest, src in dirs.items():
        # Destination exsists, but isn't a directory!
        if os.path.exists(dest) and not os.path.isdir(dest):
            print("Warning: `{}' exists, but is not a directory".format(dest))
            action = ask('What shall we do', ['ignore', 'remove'])
            if action == 'ignore':
                continue
            if action == 'remove':
                # TODO: What if dest is a dir?
                os.unlink(dest)

        # mkdir -p if required
        if not os.path.exists(dest):
            os.makedirs(dest)

        # Get list of all files we want to install and run manage_files() on that
        for src_root, _, srcfiles in os.walk(src):
            dest_root = src_root.replace(src, dest)
            srcfiles = { mp(dest_root, f): mp(src_root, f) for f in srcfiles if f != 'module.py' }
            manage_files(srcfiles)

        # Get a list of files in the destination that's *not* already in the
        # source and ask what we want to do with these files
        for root, _, destfiles in os.walk(dest):
            # TODO: Doesn't seem to work? (module vim)
            continue
            for f in destfiles:
                full_f = mp(dest, f)
                if full_f in srcfiles.keys():
                    continue

                # TODO: Make sure dirs end with /
                # TODO: Add option "view" and/or "manual merge"
                print("The file `{}' exists in `{}', but is not in `{}'".format(
                    f, dest, src))
                action = ask('What shall we do', ['ignore', 'remove', 'copy'])
                if action == 'ignore':
                    continue
                if action == 'remove':
                    os.unlink(full_f)
                if action == 'copy':
                    shutil.copy2(full_f, mp(src, f))



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
                if os.path.exists(dest):
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

        # File doesn't exist -> install
        if not os.path.exists(dest):
            install_file(src, dest)
            continue

        # Larger than 1 MiB -> don't manually merge
        if os.stat(src).st_size > 1048576 or os.stat(dest).st_size > 1048576:
            print("Skipping merge of `{}' because it is larger than 1MiB".format(src))
            continue

        # TODO: temporarily until I implement font-scale
        # Check again if the files differ, but this time ignoring lines with
        # $dotignore$; this test is comparatively slow, which is why we do it
        # here
        #dest_data = [ l for l in open(dest, 'r').readlines() if not 'dot-ignore' in l]
        #src_data = [ l for l in open(src, 'r').readlines() if not 'dot-ignore' in l ]
        #if src_data == dest_data:
        #    continue
        # End temp code

        h1 = hashlib.sha256(open(src, 'rb').read()).hexdigest()
        h2 = hashlib.sha256(open(dest, 'rb').read()).hexdigest()

        # Files are the same.
        if h1 == h2:
            continue

        run_diff(src, dest)


def run_diff(src, dest):
    subprocess.call(difftool + [dest, src])

def manage_symlinks(symlinks):
    # TODO
    # If link exist and point to something else -> ask
    # If link exists, and is not a file -> ask
    # Else -> make link
    for dest, link in symlinks.items():
        pass
        #if os.path.exists(link) and not os.path.islink(link):
        #   print("The link `{}' already exists and is not a symlink; skipping".format(link))
        #   continue

        #print(os.getcwd())
        #if os.path.exists(link) and os.lstat(link):
            #continue
        #print(link, ' -> ', dest)


def proc_module(module, code):
    """ exec() module code, do something with it """
    assigns = {}
    exec(code, assigns)

    if assigns.get('requires_root', False):
        # TODO
        print('{} requires root -> skiping'.format(module))
        return

    os.chdir(os.path.dirname(module))
    if assigns.get('files'):
        manage_files(expand_dict(assigns['files']))
    if assigns.get('dirs'):
        manage_dirs(expand_dict(assigns['dirs']))
    if assigns.get('symlinks'):
        manage_symlinks(expand_dict(assigns['symlinks']))
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

    if len(sys.argv) > 1:
        modules = [ '{}/{}/module.py'.format(root, m) for m in sys.argv[1:] ]
    else:
        modules = glob.glob(root + '/*/module.py')

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
