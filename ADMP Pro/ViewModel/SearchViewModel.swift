//
//  SearchViewModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

class SearchViewModel: ObservableObject {
	
	private let service: NetworkServiceProtocol
	
	init(service: NetworkServiceProtocol) {
		self.service = service
	}
	
	func searchProduct(for keyword: String) async throws -> ProductResponse {
		
		let query = ProductRequest(keyword: keyword)
		let response = try await service.postJSON(for: query, to: "https://admp.pro/api/v1/search-campaign-depth-of-market", responseType: ProductResponse.self)
		
		return response as! ProductResponse
	}
}
