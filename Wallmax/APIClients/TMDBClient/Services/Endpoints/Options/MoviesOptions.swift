//
//  MoviesOptions.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 23.01.2025.
//

import Foundation

/// Movies Options can be used to provide query parameters to the service functions.
/// ```swift
/// // Example:
///let url = MoviesEndpoint.popular.url(options: [.language(en-US), .page(3)])
/// ```
enum MoviesOptions {
	
	/// Defaults to en-US
	case language(String)
	
	/// Defaults to 1
	case page(Int)
	
	/// ISO-3166-1 code
	case region(String)
}

extension MoviesOptions: EndpointParameter {

	func makeQueryItem() -> URLQueryItem {
		switch self {
			case .language(let value): URLQueryItem(name: "language", value: value)
			case .page(let value): URLQueryItem(name: "page", value: String(value))
			case .region(let value): URLQueryItem(name: "region", value: value)
		}
	}
}
