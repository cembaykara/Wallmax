//
//  WallmaxTests.swift
//  WallmaxTests
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

import Testing
@testable import Wallmax

// Initialize a `MovieDBClient` so that the default configuration is available.
let client = TMDBClient()

@Suite struct WallmaxAuthTests {
	let service = AuthService()
	
	@Test("sessionId returns data")
	func testGetSessionIdSuccess() async throws {
		let data = try await service.getSessionId(for: .guest)
		#expect(data.success)
	}
}

@Suite struct WallmaxMovieServiceTests {
	
	let service = MovieService()
	
	@Test("if endpoints are returning 200",
		  arguments: [MoviesEndpoint.mostPopular, MoviesEndpoint.topRated])
	func testMoviesSuccess(endpoint: MoviesEndpoint) async throws {
		
		let data = try await service.getMovies(endpoint)
		
		// If data exists, response was received
		#expect(data.page == 1)
	}
}

import UIKit

@Suite struct WallmaxImageServiceTests {
	
	let service = ImageService()
	
	@Test("if endpoints are returning 200",
		  arguments: [ImageEndpoint.w154("/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg")])
	func testImageFetch(endpoint: ImageEndpoint) async throws {
		
		let data = try await service.fetchImage(from: endpoint)
		
		// If data exists, response was received
		#expect(data != nil)
		
		// If data can be parsed into an instance of UIImage,
		// the data is an image
		#expect(UIImage(data: data) != nil)
	}
}
