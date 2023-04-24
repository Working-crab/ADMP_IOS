//
//  ContentView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 19.04.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var selectedTab = 1
	private let appSettings = AppSettings()

	var body: some View {
		TabView(selection: $selectedTab) {
			SearchView()
				.tag(1)
				.tabItem {
					Image(systemName: "magnifyingglass.circle")
					Text("Поиск")
				}
			AdvertisingView()
				.tag(2)
				.tabItem {
					Image(systemName: "list.bullet.rectangle.fill")
					Text("Мои компании")
				}
			GenerateProductView()
				.tag(3)
				.tabItem {
					Image(systemName: "doc.badge.plus")
					Text("Генерация карты")
				}
			AccountView()
				.tag(4)
				.tabItem {
					Image(systemName: "person.circle.fill")
					Text("Мой аккаунт")
				}
		}
		.environmentObject(appSettings)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
