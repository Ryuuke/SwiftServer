//
//  MessageHandler.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

/* 
 * MARK: (Ryuuke) message handler is an abstract class, it should list all method
 * that handles messages
*/
class MessageHandler {
	
	required init() {}
	
	func handle(message: DisconnectMessage, sentBy client: Client) { }
	func handle(message: TestMessage, sentBy client: Client) { }
}
