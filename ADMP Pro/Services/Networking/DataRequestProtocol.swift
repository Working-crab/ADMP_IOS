//
//  NetworkManagerProtocol.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 22.05.2023.
//

import Foundation

enum HTTPMethod: String {
	case GET = "GET"
	case POST = "POST"
	case PUT = "PUT"
	case PATCH = "PATCH"
	case DELETE = "DELETE"
}

protocol DataRequest {
	associatedtype Response
	
	var dto: Encodable { get set }
	var url: String { get }
	var method: HTTPMethod { get }
	var headers: [String: String] { get }
	var queryItems: [String: String] { get }
	
	func encode() throws -> Data
	func decode(_ data: Data) throws -> Response
}

extension DataRequest where Response: Decodable {
	func decode(_ data: Data) throws -> Response {
		let decoder = JSONDecoder()
		return try decoder.decode(Response.self, from: data)
	}
	
	func encode() throws -> Data {
		let encoder = JSONEncoder()
		return try encoder.encode(self.dto)
	}
}

extension DataRequest {
	var headers: [String: String] { [:] }
	var queryItems: [String: String] { [:] }
}
