//
//  Message.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class Message {
	
	var messageId: MessageType {
		return 0
	}
	
	required init() { }
	
	func serialize(dataWriter: DataWriter) {
		dataWriter.write(number: messageId)
	}
	
	func deserialize(dataReader: DataReader) {
	
	}
	
	func Accept(handler: MessageHandler, withClient client: Client) {
		fatalError("should be overriden")
	}
}
