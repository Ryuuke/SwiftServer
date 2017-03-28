//
//  DataWriter.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

protocol DataWriter {
	
	var data: Data { get set }
	
	func write<T>(number: T)
	
	func write(string: String)

	func writeArray<T>(ofNumbers: [T])
	
	func writeArray(ofStrings: [String])
}
