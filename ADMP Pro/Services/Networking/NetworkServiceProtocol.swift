//
//  NetworkManager.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

protocol NetworkServiceProtocol {
	func get<T: Codable>(from url: String, decodingType: T.Type) async throws -> T
	func post<T: Codable>(to url: String, data: Codable, decodingType: T.Type) async throws -> T
	
}
