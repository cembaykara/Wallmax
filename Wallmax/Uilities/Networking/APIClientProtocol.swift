//
//  APIClient.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

protocol APIClient {
	associatedtype Configuration: NetworkConfigurable
	
	static var configuration: Configuration { get }
}
