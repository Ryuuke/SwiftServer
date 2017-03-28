//
//  Server.swift
//  swift
//
//  Created by Yassine on 23/03/2017.
//
//
import Foundation
import Socket
import Dispatch

typealias MessageType = UInt16
typealias ArraySizeType = UInt16
typealias StringSizeType = UInt16

class Server : ServerDelegate {
	
	var socketListener: Socket?
	var isRunning = true
	var connectedClients: [Int32 : Client] = [:]
	var lockQueue = DispatchQueue(label: "server.lockQueue")
	let port: Int
	
	init(port: Int) {
		self.port = port
	}
	
	deinit {
		
		for client in connectedClients.values {
			client.disconnect()
		}
		
		socketListener?.close()
	}
	
	func run() {
		
		let connectionQueue = DispatchQueue.global()
		
		connectionQueue.async { [unowned self] in
			
			do {
				self.socketListener = try Socket.create(family: .inet6)
				
				guard let socketListener = self.socketListener else {
					return
				}
				
				try socketListener.listen(on: self.port)
				
				Logger.info(message: "listening on port: \(self.port)")
				
				repeat {
					
					let socket = try socketListener.acceptClientConnection()
					
					self.addNewConnection(socket)
					
				} while self.isRunning
				
			}catch let error {
				Logger.error(message:"error: \(error)")
			}
		}
		
		dispatchMain()
	}
	
	func addNewConnection(_ socket: Socket) {
		
		let client = Client(with: socket)
		client.serverDelegate = self
	
		lockQueue.sync { [unowned self, client] in
			self.connectedClients[socket.socketfd] = client
		}
		
		client.read()
	}
	
	func remove(socket: Socket) {
		lockQueue.sync { [unowned self, socket] in
			let socketfd = socket.socketfd
			socket.close()
			self.connectedClients[socketfd] = nil
		}
	}
}
