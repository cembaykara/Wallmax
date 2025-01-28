//
//  SearchEndpoint.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 24.01.2025.
//

import Foundation

enum SearchEndpoint: Endpoint {
	
	case searchMovie
	
	static var basePath: String { "/3/search" }
	
	static var clientConfiguration: TMDBClient.TMDBConfiguration = TMDBClient.configuration
	
	var path: String {
		switch self {
			case .searchMovie: "/movie"
		}
	}
}

