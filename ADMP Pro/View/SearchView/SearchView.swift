//
//  SearchView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct SearchView: View {
	
	@StateObject private var viewModel = SearchViewModel(service: NetworkService())
	
	@State private var keyword: String = ""
	@State private var resultText: String = ""
	@State private var isLoading = false
	
	private func searchProduct() {
		Task {
			do {
				isLoading = true
				let data = try await viewModel.searchProduct(for: keyword)
				isLoading = false
				resultText = data.data
			} catch {
				print(error)
			}
		}
	}
	
	var body: some View {
		NavigationStack {
			GeometryReader { geometry in
				ScrollView(showsIndicators: false) {
					VStack(spacing: 20) {
						if isLoading {
							ProgressView()
								.frame(width: geometry.size.width)
								.frame(minHeight: geometry.size.height)
						} else {
							Text(resultText)
						}
					}
				}
			}
			.padding(.horizontal)
			.navigationTitle("Стакан цен")
		}
		.searchable(text: $keyword, prompt: "Ключевое слово")
		.onSubmit(of: .search) {
			searchProduct()
		}
	}
}

struct SearchView_Previews: PreviewProvider {
	static var previews: some View {
		SearchView()
	}
}
