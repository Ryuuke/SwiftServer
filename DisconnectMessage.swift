//
//  DisconnectMessage.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class DisconnectMessage: Message {
	
	override var messageId: MessageType {
		return 0
	}
	
	override func serialize(dataWriter: DataWriter) {
		
	}
	
	override func deserialize(dataReader: DataReader) {
		
	}
	
	override func Accept(handler: MessageHandler, withClient client: Client) {
		handler.handle(message: self, sentBy: client)
	}
}
