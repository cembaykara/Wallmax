//
//  MovieService.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

import Foundation

struct MovieService {
	
	func getMovies(_ category: MoviesEndpoint) async throws -> MoviesResponse {
		guard let url = category.url() else {
			preconditionFailure("Encountered unexpected nil while making URL for \(category)")
		}
		
		do {
			let request = try URLRequest.tmdbRequest(url: url, httpMethod: .get)
			let response = try await Session.performHttp(request).decode(as: MoviesResponse.self)
			
			return response
		} catch { throw error }
	}
}
