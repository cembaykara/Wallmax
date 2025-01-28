//
//  SearchOptions.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 24.01.2025.
//

import Foundation

enum SearchOptions {
	
	/// Search Query
	case query(String)
	
	/// Defaults to false
	case includeAdult(Bool)
	
	/// Defaults to en-US
	case language(String)
	
	case primaryReleaseYear(String)
	
	/// Defaults to 1
	case page(Int)
	
	case region(String)
	
	case year(String)
}

extension SearchOptions: EndpointParameter {
	
	func makeQueryItem() -> URLQueryItem {
		switch self {
			case .query(let value): URLQueryItem(name: "query", value: value)
			case .includeAdult(let value): URLQueryItem(name: "include_adult", value: String(value))
			case .language(let value): URLQueryItem(name: "language", value: value)
			case .primaryReleaseYear(let value): URLQueryItem(name: "primary_release_year", value: value)
			case .page(let value): URLQueryItem(name: "page", value: String(value))
			case .region(let value): URLQueryItem(name: "region", value: value)
			case .year(let value): URLQueryItem(name: "year", value: value)
		}
	}
}
