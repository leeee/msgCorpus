# -*- coding: utf-8 -*-

import sqlite3, random, sys
from friend import Friend,Message

conn = sqlite3.connect('messages.db')

c = conn.cursor()

allFriends = {}

for row in c.execute('SELECT text,handle.id,message.service,date,date_read,date_delivered,is_from_me FROM message INNER JOIN handle ON message.handle_id = handle.ROWID ORDER BY handle.ROWID,date'):
	text = row[0]
	handle = row[1]
	service = row[2]
	date = row[3]
	dateRead = row[4]
	dateDelivered = row[5]
	isFromMe = row[6]
	# allFriends.setdefault(handle, Friend(handle))
	if handle not in allFriends:
		allFriends[handle] = Friend(handle)
	allFriends[handle].addMessage(Message(text, service, date, dateRead, dateDelivered, isFromMe))


# todo: add probabilities
# todo: autocomplete
for handle in allFriends.keys():


	friend = allFriends[handle]
	messageList = friend.messagesFromMe

	if len(messageList) < 10:
		continue

	friendFile = open('generated/' + handle + '.txt', 'w')

	print 'generating text for ' + handle + '\n'
	
	dictionary = {}
	nonword = '\n'
	nfactor = 1
	previous = []

	for i in xrange(nfactor):
		previous.append(nonword)

	for message in messageList:
		if message.text != None:
			myString = message.text.encode('utf-8')
			for word in myString.split():
				dictionary.setdefault(tuple(previous),[]).append(word)
				previous = previous[1:]
				previous.append(word);
			dictionary.setdefault(tuple(previous), []).append(nonword)
			previous = []
			for i in xrange(nfactor):
				previous.append(nonword)

	maxwords = 50

	for x in xrange(50):
		for i in xrange(maxwords):
		    newword = random.choice(dictionary[tuple(previous)])
		    if newword == nonword:
				previous = []
				for i in xrange(nfactor):
					previous.append(nonword)
		    friendFile.write(newword)
		    if newword != '\n':
		    	friendFile.write(' ')
		    previous = previous[1:]
		    previous.append(newword)

	friendFile.close()

