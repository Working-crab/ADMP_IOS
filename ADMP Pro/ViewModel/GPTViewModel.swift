//
//  GPTViewModel.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.04.2023.
//

import Foundation

@MainActor
class GPTViewModel: ObservableObject {
	
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
	
	func generateProductCard(for keyword: String) async {
		self.state = .loading
		do {
			let dataDTO = ProductCardDTO(keyword: keyword)
			let data = try await networkService.post(
				to: URLManager.shared.createURL(endPoint: .gpt),
				data: dataDTO,
				decodingType: ProductCard.self)
			state = .success(data)
		} catch {
			state = .error(error)
		}
	}
}
