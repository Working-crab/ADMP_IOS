//
//  NewNetworkService.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 22.05.2023.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
	private var session: URLSession = {
		let config = URLSessionConfiguration.default
		config.requestCachePolicy = .reloadIgnoringLocalCacheData
		return URLSession(configuration: config)
	}()
	
	func request<Request>(_ request: Request) async throws -> Request.Response where Request : DataRequest {
		guard let url = URL(string: request.url) else {
			throw NSError(domain: request.url, code: 404, userInfo: nil)
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		urlRequest.httpBody = try request.encode()
		
		do {
			let (data, response) = try await session.data(for: urlRequest)
			
			guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
				let httpResponse = response as? HTTPURLResponse
				throw NSError(domain: request.url, code: httpResponse!.statusCode, userInfo: nil)
			}
						
			return try request.decode(data)
		} catch {
			throw error
		}
	}
}
