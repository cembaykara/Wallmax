//
//  HTTPMethod.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

import Foundation

enum HTTPMethod {
	case get
	case put((any Encodable)? = nil)
	case post((any Encodable)? = nil)
	case patch((any Encodable)? = nil)
	case delete
	case head
	case options
	case trace
	case connect
	
	var description: String {
		switch self {
			case .get: "GET"
			case .put: "PUT"
			case .post: "POST"
			case .patch: "PATCH"
			case .delete: "DELETE"
			case .head: "HEAD"
			case .options: "OPTIONS"
			case .trace: "TRACE"
			case .connect: "CONNECT"
		}
	}
}
