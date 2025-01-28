//
//  Movie.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 21.01.2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Movie: MovieEntity, Identifiable {
	
	@Attribute(.unique) var movieId: Int
	var title: String
	var overview: String
	var voteAverage: Double
	var posterPath: String?
	var genres: [Genre] = []
	var releaseDate: String
	
//	MARK: - Custom attributes
	var isPopular: Bool?
	
// --
	
	init(
		movieId: Int,
		title: String,
		overview: String = "",
		posterPath: String?,
		voteAverage: Double = 0,
		genres: [Genre] = [],
		releaseDate: String = "N/A",
		isPopular: Bool? = nil) {
			self.movieId = movieId
			self.title = title
			self.overview = overview
			self.posterPath = posterPath
			self.voteAverage = voteAverage
			self.genres = genres
			self.releaseDate = releaseDate
			self.isPopular = isPopular
		}
}
