# -*- coding: utf-8 -*-

import sqlite3, random, sys

conn = sqlite3.connect('messages.db')

c = conn.cursor()

# todo: add probabilities
# todo: autocomplete
dictionary = {}
nonword = '\n'
nfactor = 2
previous = []

for i in xrange(nfactor):
	previous.append(nonword)

for row in c.execute('SELECT text FROM message WHERE is_from_me=1'):
	if row[0] != None:
		myString = row[0].encode('utf-8')
		for word in myString.split():
			dictionary.setdefault(tuple(previous),[]).append(word)
			previous = previous[1:]
			previous.append(word);
		dictionary.setdefault(tuple(previous), []).append(nonword)
		previous = []
		for i in xrange(nfactor):
			previous.append(nonword)

maxwords = 100

for x in xrange(100):
	for i in xrange(maxwords):
	    newword = random.choice(dictionary[tuple(previous)])
	    if newword == nonword:
			previous = []
			for i in xrange(nfactor):
				previous.append(nonword)
	    sys.stdout.write(newword + ' ')
	    previous = previous[1:]
	    previous.append(newword)
