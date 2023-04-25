//
//  NetworkManager.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

protocol NetworkServiceProtocol {
	func postJSON<T: Query>(for query: Query, to url: String, responseType: T.Type) async throws -> T
}

enum NetworkError: Error {
	case invalidResponse
	case requestFailed
	case badURL
}
