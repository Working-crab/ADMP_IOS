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
	
	func postJSON<T:Query>(for query: Query, to url: String, responseType: T.Type) async throws -> Query {
		guard let url = URL(string: url) else {
			throw NetworkError.badURL
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		let jsonEncoder = JSONEncoder()
		let jsonData = try jsonEncoder.encode(query)
		request.httpBody = jsonData
		
		let (data, response) = try await URLSession.shared.data(for: request)
	
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
			throw NetworkError.invalidResponse
		}
		
		let jsonDecoder = JSONDecoder()
		let responseData = try jsonDecoder.decode(responseType, from: data)
			
		return responseData
	}
}


