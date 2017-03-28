//
//  Serverhandler.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class ServerHandler: MessageHandler {
	
	override func handle(message: DisconnectMessage, sentBy client: Client) {
		client.socketIsRunning = false
	}
	
	override func handle(message: TestMessage, sentBy client: Client) {
		
		let outMessage = TestMessage()
		outMessage.age = message.age
		outMessage.friendNames = message.friendNames
		outMessage.name = message.name
		outMessage.height = message.height
		outMessage.weight = message.weight
		outMessage.otherFriendNames = message.otherFriendNames
		outMessage.scores = message.scores
		
		client.send(message: outMessage)
	}
}
