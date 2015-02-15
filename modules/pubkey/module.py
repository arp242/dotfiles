# Append public ket to ~/.ssh/<F28>authorized_keys<F29>
def run():
	import os
	d = os.path.expanduser('~/.ssh')
	if not os.path.exists(d): os.mkdir(d)

	key = open('id_rsa.pub', 'r').read().strip()

	if key in open(d + '/authorized_keys', 'r').read():
		return

	with open(d + '/authorized_keys', 'a') as fp:
		fp.write(key)
		fp.write('\n')
