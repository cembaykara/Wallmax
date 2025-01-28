//
//  PopularMoviesResponse.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

import Foundation

/// Movie Response Object for top rated and popular movies
/// enpoints.
struct MoviesResponse {
	
	/// Page
	let page: Int

	/// List of movies
	let results: [MovieResult] // Should this be a generic 🧐?
	
	/// Total Pages
	let totalPages: Int
	
	/// Total Results
	let totalResults: Int
}

// MARK: - Decodable Conformance
extension MoviesResponse: Decodable {
	
	enum CodingKeys : String, CodingKey {
		case page
		case results
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}
