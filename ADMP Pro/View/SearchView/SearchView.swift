//
//  SearchView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI
import SPIndicator

struct SearchView: View {
	
	@StateObject private var viewModel = SearchViewModel(networkService: NetworkService())
	
	@State private var keyword: String = ""
	@State private var errorMessage: String = ""
	@State private var errorAlertIsShowed = false
	
	var body: some View {
		NavigationStack {
			VStack {
				TextField("Ключевое слово", text: $keyword)
					.padding(10)
					.background(Color.init(.systemGray6))
					.clipShape(Capsule())
				
				GeometryReader { geometry in
					ScrollView(showsIndicators: false) {
						VStack(spacing: 20) {
							switch viewModel.state {
							case .idle:
								VStack {
									Text("💰")
										.font(.system(size: 50))
									Text("Здесь будут отображаться рекламные ставки товара")
										.multilineTextAlignment(.center)
								}
								.frame(width: geometry.size.width)
								.frame(minHeight: geometry.size.height - 50)
							case .loading:
								ProgressView()
									.frame(width: geometry.size.width)
									.frame(minHeight: geometry.size.height)
							case .success(let response):
								Text(response.data)
							case .error(let error):
								VStack {
									Text("😓")
										.font(.system(size: 50))
										.padding(.bottom, -10)
									Text("Ой-ой")
										.font(.system(size: 20, weight: .semibold))
									Text("Кажется возникла ошибка на стороне сервера, попробуйте позже")
										.multilineTextAlignment(.center)
								}
								.frame(width: geometry.size.width)
								.frame(minHeight: geometry.size.height - 50)
								.onAppear {
									errorMessage = error.localizedDescription
									errorAlertIsShowed = true
								}
							}
						}
					}
				}
			}
			.navigationTitle("Стакан цен")
			.padding(.horizontal)
		}
		.onSubmit(of: .text) {
			Task {
				await viewModel.searchProduct(for: keyword)
			}
		}
		.SPIndicator(
		isPresent: $errorAlertIsShowed,
		title: "Ошибка сервера",
		message: errorMessage,
		duration: 2,
		presentSide: .top,
		dismissByDrag: true,
		preset: .error,
		haptic: .error
		)
	}
}

struct SearchView_Previews: PreviewProvider {
	static var previews: some View {
		SearchView()
	}
}
