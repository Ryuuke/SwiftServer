//
//  BinaryReader.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

class BinaryReader : DataReader {

	var position: Int = 0
	let data: Data
	
	init(data: Data) {
		self.data = data
	}
	
	func readData<T>() -> T {
		
		let memorySize = MemoryLayout<T>.size
		
		let subData = self.data.subdata(in: position..<position + memorySize)
		let value: T = subData.withUnsafeBytes({$0.pointee})
		position += memorySize
		return value
	}
	
	func read<T>(number: inout T) {
		number = readData()
	}
	
	func read(string: inout String) {
		
		let stringSize: StringSizeType = readData()
		let size = Int(stringSize)
		
		let subData = data.subdata(in: position..<position + size)
		position += size
		
		guard let readString = String(data: subData, encoding: .utf8) else {
			Logger.error(message: "error: cannot create an utf8 string with data \(subData)")
			return
		}
		
		string = readString
	}
	
	func readArray<T>(ofNumbers numbers: inout [T]) {
		
		assert(numbers.count == 0)
		
		let arraySize: ArraySizeType = readData()
		let totalMemory = Int(arraySize) * MemoryLayout<T>.stride
		
		let subData = data.subdata(in: position..<position + totalMemory)
		position += totalMemory
		
		numbers = subData.withUnsafeBytes({
			Array(UnsafeBufferPointer(start: $0, count: Int(arraySize)))
		})
	}
	
	func readArray(ofStrings strings: inout [String]) {
		
		assert(strings.count == 0)
		
		let arraySize: ArraySizeType = readData()
		
		for _ in 0..<arraySize {
			var str = String()
			read(string: &str)
			strings.append(str)
		}
	}
}








