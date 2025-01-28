//
//  AuthService.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 19.01.2025.

import Foundation

struct AuthService {
	
	func getSessionId(for sessionType: UserType) async throws -> SessionIdResponse {
		guard let url = AuthEndpoint.guestSession.url() else {
			preconditionFailure("Encountered unexpected nil while making URL for \(AuthEndpoint.guestSession)")
		}
		
		do {
			let request = try URLRequest.tmdbRequest(url: url, httpMethod: .get)
			return try await Session.performHttp(request).decode(as: SessionIdResponse.self)
		} catch { throw error }
	}
}
