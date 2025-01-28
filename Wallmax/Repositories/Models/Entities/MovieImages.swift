//
//  MovieImages.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 27.01.2025.
//

import Foundation
import SwiftData

@Model
final class MovieImages {
	
	@Attribute(.unique) var movieId: Int
	var posters: [String : Data]?
	
	init(movieId: Int, posters: [String : Data]? = nil) {
		self.movieId = movieId
		self.posters = posters
	}
}
