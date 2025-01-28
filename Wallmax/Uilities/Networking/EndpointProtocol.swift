//
//  Endpoint.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

import Foundation

protocol EndpointParameter {
	
	func makeQueryItem() -> URLQueryItem
}

protocol Endpoint {
	associatedtype Configuration: NetworkConfigurable
	
	/// The base path for API endpoints.
	static var basePath: String { get }
	
	/// The client to provide endpoints for.
	static var clientConfiguration: Configuration { get }
	
	/// The path for API endpoints.
	var path: String { get }
}

extension Endpoint {
	
	static private var host: String {
		guard let hostUrl = clientConfiguration.host else {
			fatalError("No host address was provided. Did you configure the APIClient correctly?")
		}
		
		return hostUrl
	}
	
	static private var preferSecureConnection: Bool {
		return !clientConfiguration.disableSecureConnection
	}
	
	static func baseURL(with parameters: [any EndpointParameter]? = nil) -> URL? {
		return newComponent(with: parameters).url
	}
	
	func url(with parameters: [any EndpointParameter]? = nil) -> URL? {
		var component = Self.newComponent(with: parameters)
		component.path.append(path)
		
		return component.url
	}
	
	func url(with parameters: [any EndpointParameter]? = nil, custom: @escaping (URLComponents, String) -> URLComponents) -> URL? {
		return custom(Self.newComponent(with: parameters), path).url
	}
	
	private static func newComponent(with parameters: [any EndpointParameter]? = nil) -> URLComponents {
		var component = URLComponents()
		component.scheme = preferSecureConnection ? "https" : "http"
		component.host = Self.host
		component.path = Self.basePath
		
		guard let parameters = parameters else { return component }
		let queryItems: [URLQueryItem] = parameters.compactMap { $0.makeQueryItem() }
		component.queryItems = queryItems
		
		return component
	}
}
