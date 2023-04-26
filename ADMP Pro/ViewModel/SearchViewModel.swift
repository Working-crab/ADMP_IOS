//
//  SearchViewModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
	
	private let networkService: NetworkServiceProtocol
	@Published var state: State = .idle

	enum State {
		case idle
		case loading
		case success(ProductCard)
		case error(Error)
	}
	
	init(networkService: NetworkServiceProtocol) {
		self.networkService = networkService
	}
	
	func searchProduct(for keyword: String) async {
		self.state = .loading
		do {
			let productDTO = ProductCardDTO(keyword: keyword)
			let response = try await networkService.post(
				to: URLManager.shared.createURL(endPoint: .search),
				data: productDTO,
				decodingType: ProductCard.self)
			self.state = .success(response)
		} catch {
			self.state = .error(error)
		}
	}
}
