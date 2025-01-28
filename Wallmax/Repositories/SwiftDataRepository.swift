//
//  SwiftDataRepository.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//
import Foundation
import SwiftData

/// Repository for SwiftData Access
struct SwiftDataRepository<T>: Repository where T: PersistentModel {
	
	let context: ModelContext
	
	init(context: ModelContext) {
		self.context = context
	}
	
	@discardableResult
	func list() throws -> [T] {
		let fetchRequest = FetchDescriptor<T>()
		
		return try context.fetch(fetchRequest)
	}
	
	@discardableResult
	func upsert(element: T) throws -> T {
		context.insert(element)
		try context.save()
		
		return element
	}
	
	@discardableResult
	func upsert(contentsOf array: [T]) throws -> [T] {
		array.forEach {
			context.insert($0)
		}
		try context.save()
		
		return array
	}
	
	func remove(element: T) throws { context.delete(element) }
	
	func drop() throws {
		let fetchRequest = FetchDescriptor<T>()
		let wholeCollection: [T] = try context.fetch(fetchRequest)
		
		wholeCollection.forEach {
			context.delete($0)
		}
		try context.save()
	}
}
