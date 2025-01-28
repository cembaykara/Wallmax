//
//  MovieDTO.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 27.01.2025.
//

import Foundation

struct MovieResult: Decodable {
	var title: String
	var id: Int
	var posterPath: String?
	var voteAverage: Double
	var overview: String
	var genreIds: [Int] = []
	var releaseDate: String
	
	enum CodingKeys : String, CodingKey {
		case id
		case title
		case overview
		case posterPath = "poster_path"
		case voteAverage = "vote_average"
		case genreIds = "genre_ids"
		case releaseDate = "release_date"
	}
}


extension MovieResult {
	
	/// Convenience Mapper to Movie
	var toEntity: Movie {
		
		var genres: [Genre] = []
		
		genreIds.forEach {
			if let genre = Genre(rawValue: $0) {
				genres.append(genre)
			}
		}
		
		return .init(
			movieId: id,
			title: title,
			overview: overview,
			posterPath: posterPath,
			voteAverage: voteAverage,
			genres: genres,
			releaseDate: releaseDate
		)
	}
}
