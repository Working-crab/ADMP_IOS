//
//  GenerateProductView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import SwiftUI
import SPIndicator

struct GenerateProductView: View {
	
	@State private var keyword: String = ""
	@State private var resultText: String = ""
	@State private var errorMessage: String = ""
	@State private var isLoading = false
	@State private var alertIsShowed = false
	@State private var errorAlertIsShowed = false
	
	@StateObject private var viewModel = GPTViewModel(networkService: NetworkService())
	
	private func generateProductCard() {
		Task {
			do {
				isLoading = true
				let data = try await viewModel.generateProductCard(for: keyword)
				isLoading = false
				resultText = data.data
			} catch {
				isLoading = false
				errorMessage = error.localizedDescription
				errorAlertIsShowed = true
			}
		}
	}
	
	var body: some View {
		NavigationStack {
			VStack {
				Section {
					GeometryReader { geometry in
						ScrollView(showsIndicators: false) {
							VStack(alignment: .center, spacing: 15) {
								if isLoading {
									VStack {
										ProgressView()
										Text("Генерируем вашу карточку 😊")
									}
									.frame(width: geometry.size.width)
									.frame(minHeight: geometry.size.height)
								} else {
									Text(resultText)
									if !resultText.isEmpty {
										Button {
											UIPasteboard.general.string = self.resultText
											alertIsShowed = true
										} label: {
											Text("Скопировать")
												.padding()
												.foregroundColor(.white)
												.background(Color.init(.systemBlue))
												.clipShape(Capsule())
										}
									}
								}
							}
						}
					}
				} header: {
					VStack(alignment: .leading) {
						Text("Здесь вы можете сгенерировать описание и индексируемые теги для вашего товара")
							.foregroundColor(.gray)
						TextField("Ключевое слово", text: $keyword)
							.padding(10)
							.background(Color.init(.systemGray6))
							.clipShape(Capsule())
					}
				}
			}
			.padding(.horizontal)
			.navigationTitle("Карточка товара")
			.onSubmit(of: .text) {
				generateProductCard()
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
			.SPIndicator(
			isPresent: $alertIsShowed,
			title: "Скопировано",
			duration: 2,
			presentSide: .top,
			dismissByDrag: true,
			preset: .done,
			haptic: .success
			)
		}
	}
}

struct GenerateProductView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateProductView()
    }
}
