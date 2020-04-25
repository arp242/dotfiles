# Append public key to ~/.ssh/authorized_keys
def run():
	import os
	d = os.path.expanduser('~/.ssh')
	if not os.path.exists(d):
		os.makedirs(d)

	path = '{}/authorized_keys'.format(d)
	key = open('id_ed25519.pub', 'r').read().strip()
	if os.path.exists(path):
		if key in open(d + '/authorized_keys', 'r').read():
			return

	with open(d + '/authorized_keys', 'a+') as fp:
		fp.write(key)
		fp.write('\n')
