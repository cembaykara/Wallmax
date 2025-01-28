//
//  MovieRepository.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

import Foundation
import SwiftData

extension SwiftDataRepository where Entity: Movie {
	
	func find(byId id: Int) throws -> Movie? {
		let predicate = #Predicate<Movie> { object in
			object.movieId == id
		}
		
		var descriptor = FetchDescriptor(predicate: predicate)
		descriptor.fetchLimit = 1
		let object = try context.fetch(descriptor)
		
		return object.first
	}
}
