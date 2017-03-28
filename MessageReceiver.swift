//
//  MessageReceiver.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class MessageReceiver {
	
	let messageHandlersLookup: [MessageType: (Message.Type, MessageHandler.Type)] = [
		MessageType(0): (DisconnectMessage.self, ServerHandler.self),
		MessageType(10): (TestMessage.self, ServerHandler.self)
	]
	
	func receive(messageData: Data, withClient client: Client) {
		
		let dataReader = BinaryReader(data: messageData)

		var messageId: MessageType = 0
		
		dataReader.read(number: &messageId)
		
		guard let (messageType, handlerType) = messageHandlersLookup[messageId] else {
			return
		}
		
		let newMessage = messageType.init()
		newMessage.deserialize(dataReader: dataReader)
		newMessage.Accept(handler: handlerType.init(), withClient: client)
	}
}
