//
//  SearchView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI
import SPIndicator

struct SearchView: View {
	
	@Environment(\.colorScheme) var colorScheme

	@StateObject private var viewModel = SearchViewModel(networkService: NetworkService())
	
	@State private var keyword: String = ""
	
	var body: some View {
		NavigationStack {
			VStack {
				CustomTextEdit(placeholder: "Ключевое слово", text: $keyword)
				GeometryReader { geometry in
					ScrollView(showsIndicators: false) {
						VStack(spacing: 20) {
							switch viewModel.state {
							case .idle:
								VStack {
									Text("Здесь будут отображаться рекламные ставки товара")
										.foregroundColor(.gray)
										.multilineTextAlignment(.center)
								}
								.frame(width: geometry.size.width)
								.frame(minHeight: geometry.size.height - 50)
							case .loading:
								CircularLoadingView(
									color: colorScheme == .dark ? .white : .black,
									lineCap: .round
								)
							case .success(let response):
								Text(response.data)
							case .error(let error):
								ErrorMessageView(error: error.localizedDescription)
									.frame(width: geometry.size.width)
									.frame(minHeight: geometry.size.height - 50)
							}
						}
					}
					.scrollDismissesKeyboard(.immediately)
					.refreshable {
						if !keyword.isEmpty {
							Task {
								await viewModel.searchProduct(for: keyword)
							}
						}
					}
				}
			}
			.navigationTitle("Стакан цен")
			.padding(.horizontal)
		}
		.onSubmit(of: .text) {
			if !keyword.isEmpty {
				Task {
					await viewModel.searchProduct(for: keyword)
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
