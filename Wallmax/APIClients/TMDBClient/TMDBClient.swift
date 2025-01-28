//
//  TMDBClient.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

import Foundation

struct TMDBClient: APIClient {
	
	/// API Configuration.
	static private(set) var configuration = TMDBConfiguration()
	
	/// Image API Configuration
	static private(set) var imageConfiguration = TMDBImageAPIConfiguration()
	
	/// Sets the configuration for the API.
	static func setConfiguration(_ configuration: TMDBConfiguration) {
		TMDBClient.configuration = configuration
	}
	
	struct TMDBConfiguration: NetworkConfigurable {
		
		/// Verbosity level for logging.
		// Don't like the place of this in this context.
		private(set) var logVerbosity: VerbosityLevel
		
		/// TMDB Read Token
		// TODO: Looks ugly. Implement an accessor or something.
		var apiKey: String? = ProcessInfo.processInfo.environment["TMDB_API_KEY"]
		
		/// TMDB Host
		let host: String? = "api.themoviedb.org"
		
		let port: Int?
		
		let disableSecureConnection: Bool
		
		init(
			logVerbosity: VerbosityLevel = .critical,
			port: Int? = nil,
			disableSecureConnection: Bool = false) {
				self.logVerbosity = logVerbosity
				self.port = port
				self.disableSecureConnection = disableSecureConnection
			}
		
	}
	
	struct TMDBImageAPIConfiguration: NetworkConfigurable {
		
		/// TMDB Image API host
		var host: String? = "image.tmdb.org"
		
		var port: Int?
		
		var disableSecureConnection: Bool
		
		init(
			port: Int? = nil,
			disableSecureConnection: Bool = false) {
				self.port = port
				self.disableSecureConnection = disableSecureConnection
			}
	}
}
