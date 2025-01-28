//
//  AuthEndpoint.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

enum AuthEndpoint: Endpoint {
	case guestSession
	case userSession
	
	static var basePath: String { "/3/authentication" }
	
	static var clientConfiguration: TMDBClient.TMDBConfiguration { TMDBClient.configuration }
	
	var path: String {
		switch self {
			case .guestSession: "/guest_session/new"
			case .userSession: "/session/new"
		}
	}
}
