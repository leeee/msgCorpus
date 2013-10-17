import random, sys

class Message:
	def __init__(self, text, service, date, dateRead, dateDelivered, isFromMe):
		self.text = text
		self.date = date
		self.service = service
		self.dateRead = dateRead
		self.dateDelivered = dateDelivered
		self.isFromMe = isFromMe

class Friend:
	def __init__(self, handle):
		self.handle = handle
		self.messages = []
		self.messagesFromMe = []
		self.messagesToMe = []


	def addMessage(self, message):
		self.messages.append(message)
		if message.isFromMe == 0:
			self.messagesToMe.append(message)
		else:
			self.messagesFromMe.append(message)
		