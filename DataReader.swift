//
//  DataReader.swift
//  SwiftServer
//
//  Created by Yassine on 23/03/2017.
//
//

import Foundation

protocol DataReader {
	
	var position: Int { get }
	
	var data: Data { get }
	
	func read<T>(number: inout T)
	
	func read(string: inout String)
	
	func readArray<T>(ofNumbers: inout [T])
	
	func readArray(ofStrings: inout [String])
}
