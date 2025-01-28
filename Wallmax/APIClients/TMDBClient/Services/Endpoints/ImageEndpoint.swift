//
//  ImageEndpoint.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 23.01.2025.
//

enum ImageEndpoint: Endpoint {
	
	// Poster Sizes
	case w92(String)
	case w154(String)
	case w185(String)
	case w342(String)
	case w500(String)
	case w780(String)
	case original(String)
	
	static var basePath: String { "/t/p" }
	
	static var clientConfiguration: TMDBClient.TMDBImageAPIConfiguration = TMDBClient.imageConfiguration
	
	var path: String {
		switch self {
			case .w92(let path): "/w92\(path)"
			case .w154(let path): "/w154\(path)"
			case .w185(let path): "/w185\(path)"
			case .w342(let path): "/w342\(path)"
			case .w500(let path): "/w500\(path)"
			case .w780(let path): "/w780\(path)"
			case .original(let path): "/original\(path)"
		}
	}
	
	var size: String {
		switch self {
			case .w92: "w92"
			case .w154: "w154"
			case .w185: "w185"
			case .w342: "w342"
			case .w500: "w500"
			case .w780: "w780"
			case .original: "original"
		}
	}
}
