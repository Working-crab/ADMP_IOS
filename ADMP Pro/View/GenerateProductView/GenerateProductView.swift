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
	@State private var alertIsShowed = false
	@State private var errorMessage: String = ""
	@State private var errorAlertIsShowed = false
	
	@StateObject private var viewModel = GPTViewModel(networkService: NetworkService())
	
	var body: some View {
		NavigationStack {
			VStack {
				VStack(alignment: .leading) {
					Text("Здесь вы можете сгенерировать описание и индексируемые теги для вашего товара")
						.foregroundColor(.gray)
					CustomTextEdit(placeholder: "Ключевое слово", text: $keyword)
				}
				
				GeometryReader { geometry in
					ScrollView(showsIndicators: false) {
						VStack(alignment: .center, spacing: 15) {
							switch viewModel.state {
							case .idle:
								EmptyView()
							case .loading:
								VStack {
									EmojiLoadingView(size: 70)
									Text("Генерируем карточку...")
								}
								.frame(width: geometry.size.width)
								.frame(minHeight: geometry.size.height)
							case .success(let response):
								Text(response.data)
									.textSelection(.enabled)
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
									print(error.localizedDescription)
								}
							}
						}
					}
					.scrollDismissesKeyboard(.immediately)
				}
			}
			.padding(.horizontal)
			.navigationTitle("Карточка товара")
			.onSubmit(of: .text) {
				if !keyword.isEmpty {
					Task {
						await viewModel.generateProductCard(for: keyword)
					}
				}
			}
			.SPIndicator(
			isPresent: $errorAlertIsShowed,
			title: "Ошибка",
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
		.toolbar {
			Text("dwdaw")
		}
	}
}

struct GenerateProductView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateProductView()
    }
}
