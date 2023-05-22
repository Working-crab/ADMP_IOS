//
//  GPTRequest.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

struct ProductCard: Decodable {
	let data: String
}

struct ProductCardDTO: Encodable {
	let keyword: String
}

struct ProductRequest: DataRequest {
	typealias Response = ProductCard
	
	var dto: Encodable
		
	var url: String {
		return URLManager.shared.createURL(endPoint: .search)
	}
	
	var queryItems: [String : String] = [:]
	var method: HTTPMethod = .POST
}

struct GPTRequest: DataRequest {
	typealias Response = ProductCard
	
	var dto: Encodable
		
	var url: String {
		return URLManager.shared.createURL(endPoint: .gpt)
	}
	
	var queryItems: [String : String] = [:]
	var method: HTTPMethod = .POST
}
