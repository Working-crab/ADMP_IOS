//
//  GenerateProductView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import SwiftUI

struct GenerateProductView: View {
	
	@State private var keyword: String = ""
	@State private var resultText: String = ""
	@State private var isLoading = false
	
	@StateObject private var viewModel = GPTViewModel(networkService: NetworkService())
	
	var body: some View {
		NavigationStack {
			VStack(alignment: .center) {
				Text("Генерация карточки товара")
				TextField("Товар", text: $keyword)
					.frame(width: 220)
				Button {
					Task {
						do {
							isLoading = true
							let data = try await viewModel.generateProductCard(for: keyword)
							isLoading = false
							resultText = data.data
						} catch {
							print(error)
						}
					}
				} label: {
					Text("Сгенерировать")
				}
				if isLoading {
					Text("Идет обработка вашего запроса...")
					ProgressView()
				} else {
					Text(resultText)
				}
			}
			.padding()
		}
	}
}

struct GenerateProductView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateProductView()
    }
}
