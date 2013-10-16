# -*- coding: utf-8 -*-

import sqlite3, random, sys

conn = sqlite3.connect('messages.db')

c = conn.cursor()

# dictionary of words to followup words and probabilities?
dictionary = {}
nonword = '\n'
w1 = nonword
for row in c.execute('SELECT text FROM message WHERE is_from_me=1'):
	if row[0] != None:
		myString = row[0].encode('utf-8')
		for word in myString.split():
			dictionary.setdefault(w1,[]).append(word)
			w1 = word;
		dictionary.setdefault(w1, []).append(nonword)
		w1 = nonword

maxwords = 100

for x in xrange(100):
	for i in xrange(maxwords):
	    newword = random.choice(dictionary[w1])
	    # if newword == nonword:
	    # 	sys.stdout.write('\n')
	    sys.stdout.write(newword + ' ')
	    w1 = newword
