//
//  LogEntry.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 19.01.2025.
//

import Foundation

struct LogEntry {
	
	///  The `OSLog` verbosity
	var verbosityLevel: VerbosityLevel
	
	/// Message to be logged to the `OSLog`
	var message: String
	
	init(verbosityLevel: VerbosityLevel, message: String) {
		self.verbosityLevel = verbosityLevel
		self.message = message
	}
}
