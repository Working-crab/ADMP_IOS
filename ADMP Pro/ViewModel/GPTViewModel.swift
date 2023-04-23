//
//  GPTViewModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

class GPTViewModel: ObservableObject {
	
	private let networkService: NetworkServiceProtocol
	
	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}
	
	func generateProductCard(for keyword: String) async throws -> GPTResponse {
				
		let query = GPTRequest(keyword: keyword)
		let data = try await networkService.postJSON(for: query, to: "https://admp.pro/api/v1/gpt-generate-card-description", responseType: GPTResponse.self)
				
		return data as! GPTResponse
	}
}
