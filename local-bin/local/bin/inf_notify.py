#!/usr/bin/env python3
#
# https://wiki.archlinux.org/index.php/Desktop_notifications
#

import time, socket

import gi
gi.require_version('Notify', '0.7')
from gi.repository import Notify

servers = [
	{
		'server': ('cerberon.net', 17778),
		'last': 0,
	},
	{
		'server': ('cerberon.net', 27778),
		'last': 0,
	},
	{
		'server': ('xplod.de', 7778),
		'last': 0,
	},
]

def query(s, cmd):
	s.sendall(b'\\' + cmd + b'\\')
	key = ''
	data = {}
	for i, k in enumerate(s.recv(16384).split(b'\\')):
		if k == b'':
			continue
		if i % 2:
			key = k.decode()
		else:
			data[key] = k.decode()
	return data

def get_list(server):
	players = {}
	with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
		s.connect(server)
		status = query(s, b'status')
		# TODO: Not sure how to list player names... Maybe this has the answer:
		# https://duckduckgo.com/?q=qstat&ia=web
		#players = query(s, b'players')

	return status

def loop(do_notify=True):
	for s in servers:
		try:
			status = get_list(s['server'])
		except ConnectionRefusedError:
			continue

		num = status.get('numplayers', None)
		if num is None:
			continue

		if num != s['last']:
			if do_notify:
				name = status.get('hostname', s['server'][0])
				Notify.Notification.new('Number of players for "{}" changed:\nfrom {} to {}'.format(
					name, s['last'], num)).show()
			s['last'] = num

if __name__ == '__main__':
	Notify.init('INF notify')
	loop(False)
	while True:
		loop()
		time.sleep(20)
