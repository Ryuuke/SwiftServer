//
//  BinaryWriter.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class BinaryWriter : DataWriter {
	
	var data = Data()
	
	func write<T>(number: T) {
		var copy = number
		let buffer = UnsafeBufferPointer(start: &copy, count: 1)
		data.append(buffer)
	}
	
	func write(string str: String) {
		
		let size = StringSizeType(str.characters.count)
		self.write(number: size)
		
		guard let strData = str.data(using: .utf8) else {
			Logger.error(message:"error: \(str) is not an utf8 string")
			return
		}
		
		data.append(strData)
	}

	func writeArray<T>(ofNumbers numbers: [T]) {
		
		let size = ArraySizeType(numbers.count)
		self.write(number: size)
		
		let buffer = numbers.withUnsafeBufferPointer({$0})
		data.append(buffer)
	}
	
	func writeArray(ofStrings strings: [String]) {
		
		let size = ArraySizeType(strings.count)
		self.write(number: size)
		
		for i in 0..<strings.count {
			write(string: strings[i])
		}
	}
}







