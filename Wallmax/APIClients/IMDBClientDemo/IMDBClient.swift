//
//  IMDBClient.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 28.01.2025.
//

import Foundation


/// This is a mock IMDB Client Object.
/// It's purpose is to demonstrate how easy it is to
/// implement additional sources to Wallmax app.
///
struct IMDBClient: APIClient {
	
	/// API Configuration.
	static private(set) var configuration = IMDBConfiguration()
	
	/// Sets the configuration for the API.
	static func setConfiguration(_ configuration: IMDBConfiguration) {
		IMDBClient.configuration = configuration
	}
	
	struct IMDBConfiguration: NetworkConfigurable {
		
		/// Verbosity level for logging.
		// Don't like the place of this in this context.
		private(set) var logVerbosity: VerbosityLevel
		
		/// IMDB Token
		// TODO: Looks ugly. Implement an accessor or something.
		var apiKey: String? = ""
		
		/// TMDB Host
		let host: String? = ""
		
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
}
