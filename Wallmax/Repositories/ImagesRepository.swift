//
//  ImagesRepository.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 27.01.2025.
//

import Foundation
import SwiftData

extension SwiftDataRepository where Entity: MovieImages {
	
	func findByMovieId(_ movieId: Int) throws -> MovieImages? {
		let predicate = #Predicate<MovieImages> { object in
			object.movieId == movieId
		}
		
		var descriptor = FetchDescriptor(predicate: predicate)
		descriptor.fetchLimit = 1
		let object = try context.fetch(descriptor)
		
		return object.first
	}
	
}
