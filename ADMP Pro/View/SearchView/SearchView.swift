//
//  SearchView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct SearchView: View {
	
	let goods = ["Чайник","Чехол","Платье","Подставка для ноутбука","Часы","Коврик для мыши","Туфли"]
	
	@State private var queryString: String = ""
	
	var searchResults: [String] {
		if queryString.isEmpty {
			return goods
		} else {
			return goods.filter{ $0.lowercased().contains(queryString.lowercased()) }
		}
	}
	
	var body: some View {
		NavigationStack {
			ScrollView(showsIndicators: false) {
				VStack(spacing: 20) {
					ForEach(searchResults, id: \.self) { name in
						VStack {
							Image(systemName: "shippingbox.fill")
								.resizable()
								.frame(width: 80, height: 80)
							Text(name)
						}
					}
				}
			}
			.navigationTitle("Стакан цен")
		}
		.searchable(text: $queryString, prompt: "Ключевое слово")
	}
}

struct SearchView_Previews: PreviewProvider {
	static var previews: some View {
		SearchView()
	}
}
