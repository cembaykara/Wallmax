//
//  SessionIdResponse.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 20.01.2025.
//

import Foundation

struct SessionIdResponse: Decodable {
	let success: Bool
	let guestSessionId: String
	let expiresAt: String
	
	enum CodingKeys: String, CodingKey {
		case success
		case guestSessionId = "guest_session_id"
		case expiresAt = "expires_at"
	}
}
