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
//	@State private var resultText: String = ""
	@State private var errorMessage: String = ""
	@State private var isLoading = false
	@State private var alertIsShowed = false
	@State private var errorAlertIsShowed = false
	
	@StateObject private var viewModel = GPTViewModel(networkService: NetworkService())
	
	var body: some View {
		NavigationStack {
			VStack {
				Section {
					GeometryReader { geometry in
						ScrollView(showsIndicators: false) {
							VStack(alignment: .center, spacing: 15) {
								switch viewModel.state {
								case .idle:
									EmptyView()
								case .loading:
									VStack {
										ProgressView()
										Text("Генерируем вашу карточку 😊")
									}
									.frame(width: geometry.size.width)
									.frame(minHeight: geometry.size.height)
								case .success(let response):
									Text(response.data)
									Button {
										UIPasteboard.general.string = response.data
										alertIsShowed = true
									} label: {
										Text("Скопировать")
											.padding()
											.foregroundColor(.white)
											.background(Color.init(.systemBlue))
											.clipShape(Capsule())
									}
								case .error(let error):
									VStack {}
									.onAppear {
										errorMessage = error.localizedDescription
										errorAlertIsShowed = true
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
				Task {
					await viewModel.generateProductCard(for: keyword)
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
