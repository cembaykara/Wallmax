//
//  SearchService.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 24.01.2025.
//

import Foundation

struct SearchService {
	
	func search(with options: [SearchOptions]) async throws -> MoviesResponse {
		guard let url = SearchEndpoint.searchMovie.url(with: options) else {
			preconditionFailure("Encountered unexpected nil while making URL for \(SearchEndpoint.searchMovie)")
		}
		
		do {
			let request = try URLRequest.tmdbRequest(url: url, httpMethod: .get)
			let response = try await Session.performHttp(request).decode(as: MoviesResponse.self)
			
			return response
		} catch { throw error }
	}
}
