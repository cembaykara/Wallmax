//
//  Session.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

import Foundation
import Combine
import OSLog

/// Interceptor
/// * Can be provided to an Http request via the `Session`.
/// Can be used for things like, retry upon error or for refreshing tokens etc.
protocol Interceptor {
	
	/// Indicates how many times the request will be retried
	var retryCount: Int { get set }
	
	/// Indicates the dealy between retries
	var delayInterval: TimeInterval { get set }
	
	/// Adapts the request for retrying
	func adapt(request: URLRequest) async -> Result<URLRequest, Error>
}

actor Session {
	
	static var shared = Session()
	
	/// A convenience method to load data using `URLRequest`.
	///
	/// - Supports intercepting requests with a custom `Interceptor`.
	@discardableResult
	public static func performHttp(_ request: URLRequest, interceptor: Interceptor? = nil) async throws -> Data {
		let session = URLSession.shared
		
		let requestLogger = MXLogger(subsystem: "Wallmax", category: "Networking")
		
		return try await Task.retryable(maxRetryCount: interceptor?.retryCount ?? 0, retryDelay: interceptor?.delayInterval ?? 0) {
			
			var _request = request
			
			if let interceptor {
				do {
					_request = try await interceptor.adapt(request: request).get()
				} catch {
					requestLogger.log(
						LogEntry(
							verbosityLevel: .warning,
							message: "Interceptor encountered a problem. Reason: " +  error.localizedDescription))
				}
			}
			
			requestLogger.log(
				LogEntry(
					verbosityLevel: .info,
					message: "\(String(describing: _request.httpMethod)) \(_request.description)"))
			
			do {
				let (data, response) = try await session.data(for: _request)
				
				guard let httpResponse = response as? HTTPURLResponse else {
					throw RequestError.noResponse
				}
				
				guard (200...299).contains(httpResponse.statusCode) else {
					throw RequestError.invalidStatusCode(httpResponse.statusCode, data)
				}
				
				return data
			} catch { throw error }
		}.value
	}
}

public enum RequestError: LocalizedError {
	case error(Error)
	case invalidStatusCode(Int, Data)
	case noResponse
	
	public var errorDescription: String? {
		switch self {
			case .error(let error): error.localizedDescription
			case .invalidStatusCode(let code, _): "Error Code: \(code)"
			case .noResponse: "No Response"
		}
	}
}
