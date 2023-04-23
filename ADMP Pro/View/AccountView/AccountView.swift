//
//  AccountView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI
import Charts

struct AccountView: View {
	
	@State private var showingSettingsSheet = false
	
	var body: some View {
		NavigationStack {
			VStack {
				Section {
					ScrollView(showsIndicators: false) {
						VStack(alignment: .leading, spacing: 15) {

							VStack(alignment: .leading) {
								Text("Сэкономлено")
									.font(.system(size: 18, weight: .semibold))
									.padding(.bottom, 3)
								HStack {
									Text("За сегодня:")
									Spacer()
									Text("560.2 ₽")
								}
								HStack {
									Text("За месяц")
									Spacer()
									Text("2660.11 ₽")
								}
								HStack {
									Text("За все время:")
									Spacer()
									Text("8571.52 ₽")
								}
							}
							
							VStack(spacing: 5) {
								VStack(alignment: .leading) {
									Text("История операций")
										.font(.system(size: 18, weight: .semibold))
										.padding(.bottom, 3)
									HStack {
										Text("Рекламная компания")
										Spacer()
										Text("14.04.2023")
									}
									HStack {
										Text("Рекламная компания")
										Spacer()
										Text("11.04.2023")
									}
									HStack {
										Text("Создание товара")
										Spacer()
										Text("02.04.2023")
									}
								}
								Button {
									showingSettingsSheet.toggle()
								} label: {
									Text("Полная история")
										.foregroundColor(.white)
										.padding(10)
										.background(Color.init(.systemBlue))
										.clipShape(Capsule())
								}
								.padding(.top, 10)
							}
						}
					}
				} header: {
					HeaderView()
				}
			}
			.padding(.horizontal, 15)
			.navigationTitle("Мой Аккаунт")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Menu {
						Button {
							showingSettingsSheet.toggle()
						} label: {
							HStack {
								Text("Настройки профиля")
								Spacer()
								Image(systemName: "gearshape")
							}
						}
					} label: {
						Image(systemName: "ellipsis")
							.foregroundColor(.blue)
					}
				}
			}
		}
		.sheet(isPresented: $showingSettingsSheet) {
			SheetView()
		}
	}
}

struct HeaderView: View {
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text("Иван Ровков")
					.font(.system(size: 25))
				Text("Premium")
			}
			
			Spacer()
			
			NavigationLink(destination: SubscriptionView()) {
				Text("Улучшить")
					.foregroundColor(.white)
					.padding(10)
					.background(Color.init(.systemBlue))
					.clipShape(Capsule())
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}

struct SheetView: View {
	@Environment(\.dismiss) var dismiss
	
	@ObservedObject var settings = AppSettings.shared

	var body: some View {
		NavigationStack {
			ScrollView {
				VStack {
					VStack {
						Text("Токен")
							.bold()
						TextField("Токен Wilberries", text: settings.$wbToken)
							.padding(10)
							.background(Color.init(.systemGray6))
							.clipShape(Capsule())
					}
				}
				.frame(width: .infinity, alignment: .leading)
			}
			.padding(.horizontal)
			.toolbar {
				ToolbarItem {
					Button("Готово") {
						dismiss()
					}
				}
			}
		}
		.navigationTitle("Настройки")
	}
}

struct AccountView_Previews: PreviewProvider {
	static var previews: some View {
		AccountView()
	}
}
