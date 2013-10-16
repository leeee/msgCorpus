# -*- coding: utf-8 -*-

import sqlite3

conn = sqlite3.connect('messages.db')

c = conn.cursor()

# list of numbers
handlesFile = open('output/handles.txt', 'w')

for row in c.execute('SELECT id FROM handle'):
	handlesFile.writelines(row[0] + '\n')

handlesFile.close()


# texts from me
meFile =  open('output/me.txt', 'w')

for row in c.execute('SELECT text FROM message WHERE is_from_me=1'):
	if row[0] != None:
		myString = row[0] + u'\n'
		meFile.write(myString.encode("utf-8"))

meFile.close()

# texts by person
allFile = open('output/all.txt', 'w')

for row in c.execute('SELECT text,handle.id,message.service,date,date_read,date_delivered,is_from_me FROM message INNER JOIN handle ON message.handle_id = handle.ROWID ORDER BY handle.ROWID,date'):
	if row[0] != None:
		myString = u'+++' + row[0] + u'+++,'
		allFile.write(myString.encode("utf-8"))
	for data in row[1:]:
		allFile.write(str(data) + ',')
	allFile.write('\n')


allFile.close()