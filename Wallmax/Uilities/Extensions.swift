//
//  Extensions.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 19.01.2025.
//

import Foundation
import SwiftUI

// MARK: - Data

public extension Data {
	
	/// A convenience method to decode data to a `Decodable` with a `JSONDecoder`.
	func decode<T>(as object: T.Type, withDecoder decoder: JSONDecoder = .init()) async throws -> T where T: Decodable {
		do {
			let jsonObject = try decoder.decode(T.self, from: self)
			let logger = MXLogger(subsystem: "Wallmax", category: "Networking")
			
			return jsonObject
		} catch { throw error }
	}
}

// MARK: - Task

extension Task where Failure == Error {
	
	/// Executes an asynchronous operation with retry logic.
	///
	/// For more information on retry patterns, visit
	/// https://www.swiftbysundell.com/articles/retrying-an-async-swift-task/
	///
	@discardableResult
	static func retryable(
		maxRetryCount: Int = 0,
		retryDelay: TimeInterval = 0,
		operation: @Sendable @escaping () async throws -> Success) -> Task {
			Task {
				for _ in 0..<maxRetryCount {
					do { return try await operation() }
					catch {
						let delay = UInt64(1_000_000_000 * retryDelay)
						try await Task<Never, Never>.sleep(nanoseconds: delay)
						
						continue
					}
				}
				
				try Task<Never, Never>.checkCancellation()
				return try await operation()
			}
		}
}

// MARK: - String

extension String {
	
	func dateString(withFormat format: String = "yyyy-MM-dd") -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"

		if let date = formatter.date(from: self) {
			formatter.dateFormat = format
			return formatter.string(from: date)
		}
		
		return self
	}
}

// MARK: - Color

extension Color {
	
	init(hex: String) {
		
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)

		let a, r, g, b: UInt64

		switch hex.count {
			case 3:
				(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
			case 6:
				(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
			case 8:
				(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
			default:
				(a, r, g, b) = (1, 1, 1, 0)
		}
		
		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue: Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
}
