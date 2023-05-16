//
//  GPTNetworkService.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
		
	private let session: URLSession
	
	init() {
		let config = URLSessionConfiguration.default
		config.requestCachePolicy = .reloadIgnoringLocalCacheData
		self.session = URLSession(configuration: config)
	}
	
	func get<T: Codable>(from url: String, decodingType: T.Type) async throws -> T {
		guard let url = URL(string: url) else {
			throw NetworkError.badURL
		}
		
		do {
			let (data, response) = try await session.data(from: url)
			
			guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
				throw NetworkError.badResponse
			}
			
			let decodedData = try JSONDecoder().decode(decodingType, from: data)
			
			return decodedData
		} catch {
			throw error
		}
	}
	
	func post<T: Codable>(to url: String, data: Codable, decodingType: T.Type) async throws -> T {
		guard let url = URL(string: url) else {
			throw NetworkError.badURL
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			let body = try JSONEncoder().encode(data)
			request.httpBody = body
		} catch {
			throw NetworkError.badRequest
		}
		
		do {
			let (data, response) = try await session.data(for: request)
			
			guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
				throw NetworkError.badResponse
			}
			
			let decodedData = try JSONDecoder().decode(decodingType, from: data)
			
			return decodedData
		} catch {
			throw error
		}
	}
}


