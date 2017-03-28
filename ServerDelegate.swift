//
//  ServerDelegate.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation
import Socket

protocol ServerDelegate : class {

	func remove(socket: Socket)
}
