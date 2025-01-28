//
//  VerbosityLevel.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 19.01.2025.
//

import Foundation

/// Enum representing the verbosity levels for logging.
public enum VerbosityLevel: Comparable {
	
	/// Log Verbosity none
	case none
	
	/// Log Verbosity notice
	case notice
	
	///Log Verbosity info
	case info
	
	/// Log Verbosity debug
	case debug
	
	/// Log Verbosity trace
	case trace
	
	/// Log Verbosity warning
	case warning
	
	/// Log Verbosity error
	case error
	
	/// Log Verbosity fault
	case fault
	
	/// Log Verbosity critical
	case critical
}
