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
	
	var body: some View {
		NavigationStack {
			ScrollView(showsIndicators: false) {
				VStack(spacing: 20) {
					Text(resultText)
				}
			}
			.padding(.horizontal)
			.navigationTitle("Стакан цен")
		}
		.searchable(text: $keyword, prompt: "Ключевое слово")
		.onSubmit(of: .search) {
			Task {
				do {
					let data = try await viewModel.searchProduct(for: keyword)
					resultText = data.data
				} catch {
					print(error)
				}
			}
		}
	}
}

struct SearchView_Previews: PreviewProvider {
	static var previews: some View {
		SearchView()
	}
}
