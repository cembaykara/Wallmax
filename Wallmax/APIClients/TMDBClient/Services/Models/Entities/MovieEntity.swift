//
//  MovieEntity.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

protocol MovieEntity: EntityProtocol {
	
	var movieId: Int { get }
	var title: String { get }
	var overview: String { get }
	var voteAverage: Double { get }
	var posterPath: String? { get }
	var genres: [Genre] { get }
	var releaseDate: String { get }
	
	//
	// ... no need for the whole object
}
