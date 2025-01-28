//
//  NetworkConfigurable.swift
//  Wallmax
//
//  Created by Baris Cem Baykara on 18.01.2025.
//

protocol NetworkConfigurable {
	
	var host: String? { get }
	
	var port: Int? { get }
	
	var disableSecureConnection: Bool { get }
}
