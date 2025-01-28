//
//  MXLogger.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 19.01.2025.
//
import Foundation
import OSLog

class MXLogger {
	
	private let logger: Logger
	
	init(subsystem: String, category: String) {
		self.logger = Logger(subsystem: subsystem, category: category)
	}
	
	/// Writes a message to the `OSLog` based on the configured log verbosity level.
	func log(_ entry: LogEntry) {
		
		if entry.verbosityLevel <= TMDBClient.configuration.logVerbosity {
			switch entry.verbosityLevel {
				case .none:
					return
				case .notice:
					logger.notice("\(entry.message)")
				case .info:
					logger.info("\(entry.message)")
				case .debug:
					logger.debug("\(entry.message)")
				case .trace:
					logger.trace("\(entry.message)")
				case .warning:
					logger.warning("\(entry.message, privacy: .private(mask: .hash))")
				case .error:
					logger.error("\(entry.message)")
				case .fault:
					logger.fault("\(entry.message)")
				case .critical:
					logger.critical("\(entry.message)")
			}
		}
	}
	
	/// Logs any object to console
	func consoleLog<T: Any>(_ object: T) {
		print(object)
	}
	
	/// Logs a message and an object to console
	func consoleLog<T: Any>(_ string: String, _ object: T) {
		print(string, object)
	}
	
	/// Logs a Data object as JSON to the console
	func consoleLogJSON(data: Data) throws {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		
		let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
		print(json)
	}
}
