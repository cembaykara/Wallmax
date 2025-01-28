//
//  MoviesEndpoint.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

import Foundation

enum MoviesEndpoint: Endpoint {
	case mostPopular
	case topRated
	
	static var basePath: String { "/3/movie" }
	
	static var clientConfiguration: TMDBClient.TMDBConfiguration = TMDBClient.configuration
	
	var path: String {
		switch self {
			case .mostPopular:
				return "/popular"
			case .topRated:
				return "/top_rated"
		}
	}
}

