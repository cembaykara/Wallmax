//
//  TMDBExtensions.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 28.01.2025.
//

import Foundation

// MARK: - URLRequest

extension URLRequest {
	
	/// A convenience method to build a `URLRequest` object for `The Movie DB` requests.
	/// * Assumes `Content-Type - application/json`
	/// * Attaches `Bearer Token`
	static func tmdbRequest(url: URL, httpMethod: HTTPMethod) throws -> URLRequest {
		var request = URLRequest(url: url)
		
		if let apiKey = TMDBClient.configuration.apiKey {
			request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
		}
		
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		switch httpMethod {
			case .put(let body), .post(let body), .patch(let body):
				if let body { request.httpBody = try JSONEncoder().encode(body) }
			default: break
		}
		
		request.httpMethod = httpMethod.description
		return request
	}
}
