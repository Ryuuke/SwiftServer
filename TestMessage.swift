//
//  TestMessage.swift
//  SwiftServer
//
//  Created by Yassine on 25/03/2017.
//
//

import Foundation

class TestMessage: Message {
	
	override var messageId: MessageType {
		return 10
	}
	
	var age: Int32 = 0
	var name: String = ""
	var friendNames = [String]()
	var scores = [UInt8]()
	var weight: Float = 0
	var height: Double = 0
	var otherFriendNames = [String]()
	
	override func serialize(dataWriter: DataWriter) {
		super.serialize(dataWriter: dataWriter)
		dataWriter.write(number: age)
		dataWriter.write(string: name)
		dataWriter.writeArray(ofStrings: friendNames)
		dataWriter.writeArray(ofNumbers: scores)
		dataWriter.write(number: weight)
		dataWriter.write(number: height)
		dataWriter.writeArray(ofStrings: otherFriendNames)
	}
	
	override func deserialize(dataReader: DataReader) {
		dataReader.read(number: &age)
		dataReader.read(string: &name)
		dataReader.readArray(ofStrings: &friendNames)
		dataReader.readArray(ofNumbers: &scores)
		dataReader.read(number: &weight)
		dataReader.read(number: &height)
		dataReader.readArray(ofStrings: &otherFriendNames)
	}
	
	override func Accept(handler: MessageHandler, withClient client: Client) {
		handler.handle(message: self, sentBy: client)
	}
}
