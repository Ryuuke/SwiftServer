
//
//  Client.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation
import Socket

class Client {
	
	static let bufferSize = 8194
	let socket: Socket
	var socketIsRunning = true
	let messageReceiver = MessageReceiver()
	weak var serverDelegate: ServerDelegate?
	
	init(with socket: Socket) {
		self.socket = socket
		self.socket.readBufferSize = Client.bufferSize
	}
	
	public func send(message: Message) {
		let dataWriter = BinaryWriter()
		message.serialize(dataWriter: dataWriter)
		let _ = try? self.socket.write(from: dataWriter.data)
	}
	
	public func disconnect() {
		self.serverDelegate?.remove(socket: self.socket)
	}
	
	public func read() {
		
		let socketQueue = DispatchQueue.global(qos: .default)
		
		socketQueue.async { [unowned self] in
			
			do {
				
				while self.socketIsRunning {
					
					try autoreleasepool {
						
						var readData = Data()
						let readBytes = try self.socket.read(into: &readData)
						
						if readBytes <= 0 {
							self.socketIsRunning = false
							return
						}
						
						self.messageReceiver.receive(messageData: readData, withClient: self)
					}
				}
				
				self.disconnect()
				
			} catch let error {
				Logger.error(message:"error: \(error)")
			}
		}
	}
}
