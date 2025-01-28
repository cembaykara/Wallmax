//
//  Repository.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

import Foundation

protocol Repository {
	
	associatedtype Entity
	
	// TODO: Maybe take an optional range for pagination.
	func list() throws -> [Entity]
	
	func upsert(element: Entity) throws -> Entity
	
	func upsert(contentsOf: [Entity]) throws -> [Entity]
	
	func remove(element: Entity) throws
	
	func drop() throws
	
	// TODO: Define as needed.
}
