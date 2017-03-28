//
//  Logger.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class Logger {
	
	enum ConsoleColor: UInt8 {
		case Black = 30,
		Red,
		Green,
		Yellow,
		Blue,
		Magenta,
		Cyan,
		White
	}
	
	static var out = FileHandle.standardError
	
	private class func logColored(message: String, color: ConsoleColor) {
		
		guard let str = "\u{001B}[0;\(color.rawValue)m\(message)".data(using: .utf8) else {
			return
		}
		
		out.write(str)
	}
	
	class func warning(message: String) {
		logColored(message: message, color: ConsoleColor.Yellow)
	}
	
	class func error(message: String) {
		logColored(message: message, color: ConsoleColor.Red)
	}
	
	class func info(message: String) {
		print(message)
	}
}
