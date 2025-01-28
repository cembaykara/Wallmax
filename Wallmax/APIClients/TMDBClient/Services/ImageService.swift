//
//  ImageService.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 23.01.2025.
//

import Foundation

struct ImageService {
	
	func fetchImage(from source: ImageEndpoint) async throws -> Data {
		guard let url = source.url() else {
			preconditionFailure("Encountered unexpected nil while making URL for \(source)")
		}
		
		do {
			let request = try URLRequest.tmdbRequest(url: url, httpMethod: .get)
			let imgData = try await Session.performHttp(request)
			
			return imgData
		} catch { throw error }
	}
}
