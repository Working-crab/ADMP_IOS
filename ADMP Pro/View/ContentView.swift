//
//  ContentView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 19.04.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var selectedTab = "Поиск"
    @EnvironmentObject var appSettings: AppStore

	init() {
		UITabBar.appearance().isHidden = true
	}

	var body: some View {
		ZStack(alignment: .bottom) {
			TabView(selection: $selectedTab) {
				SearchView()
					.tag("Поиск")
				AdvertisingView()
					.tag("Рекламные компании")
				GenerateProductView()
					.tag("Генерация товара")
				AccountView()
					.tag("Профиль")
			}
			
			HStack {
				Spacer()
				TabBarItem(tabName: "Поиск", selectedTab: $selectedTab, image: "magnifyingglass.circle")
				Spacer()
				TabBarItem(tabName: "Рекламные компании", selectedTab: $selectedTab, image: "list.bullet.rectangle.fill")
				Spacer()
				TabBarItem(tabName: "Генерация товара", selectedTab: $selectedTab, image: "doc.plaintext.fill")
				Spacer()
				TabBarItem(tabName: "Профиль", selectedTab: $selectedTab, image: "person.circle.fill")
				Spacer()
			}
			.padding(.vertical, 15)
			.frame(maxWidth: .infinity)
			.background(Color(.systemGray6))
		}
		.ignoresSafeArea(.keyboard)
	}
}

struct TabBarItem: View {
	
	@State var tabName: String
	@Binding var selectedTab: String
	
	var image: String
		
	var body: some View {
		Button {
			withAnimation(.spring()) {
				selectedTab = tabName
			}
		} label: {
			HStack {
				Image(systemName: image)
					.font(.system(size: 18))
				if selectedTab == tabName {
					Text(tabName)
						.font(.system(size: 15))
				}
			}
			.foregroundColor(Color(.label))
		}
		.padding(10)
		.opacity(selectedTab == tabName ? 1 : 0.6)
		.background(selectedTab == tabName ? Color(.systemBackground) : Color(.systemGray6))
		.clipShape(Capsule())
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
