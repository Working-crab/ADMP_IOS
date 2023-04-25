//
//  SearchViewModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
	
	private let service: NetworkServiceProtocol
	@Published var state: State = .idle

	enum State {
		case idle
		case loading
		case success(ProductResponse)
		case error(Error)
	}
	
	init(service: NetworkServiceProtocol) {
		self.service = service
	}
	
	func searchProduct(for keyword: String) async {
		self.state = .loading
		do {
			let query = ProductRequest(keyword: keyword)
			let response = try await service.postJSON(for: query, to: "https://admp.pro/api/v1/search-campaign-depth-of-market", responseType: ProductResponse.self)
			self.state = .success(response as! ProductResponse)
		} catch {
			self.state = .error(error)
		}
	}
}
