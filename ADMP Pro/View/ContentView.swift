//
//  ContentView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 19.04.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var selectedTabIndex = 1

	var body: some View {
		TabView(selection: $selectedTabIndex) {
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
					Text("Рекламные компании")
 				}
			AccountView()
				.tag(3)
				.tabItem {
					Image(systemName: "person.circle.fill")
					Text("Мой аккаунт")
				}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
