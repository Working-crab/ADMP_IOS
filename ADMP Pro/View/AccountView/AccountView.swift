//
//  AccountView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI
import Charts

struct AccountView: View {
	
	var data: [Product] = [
		.init(name: "Платье", salesCount: 14),
		.init(name: "Шарф", salesCount: 25),
		.init(name: "Галстук", salesCount: 20),
		.init(name: "Чехол для IPhone", salesCount: 13),
		.init(name: "Кроссовки Nike", salesCount: 25),
		.init(name: "Жалюзи", salesCount: 34),
		.init(name: "AirPods Pro", salesCount: 27)
	]
	
	var body: some View {
		NavigationStack {
			VStack {
				Section {
					ScrollView(showsIndicators: false) {
						VStack(alignment: .leading, spacing: 15) {
							Text("График продаж")
								.font(.system(size: 18, weight: .semibold))
							Chart {
									ForEach(data) { product in
											BarMark(
												x: .value("Товар", product.name),
												y: .value("Total Count", product.salesCount)
											)
									}
							}
							.frame(height: 300)
							
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
								Button {} label: {
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
					NavigationLink(destination: AccountSettingsView()) {
						Image(systemName: "gearshape")
					}
				}
			}
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

struct AccountView_Previews: PreviewProvider {
	static var previews: some View {
		AccountView()
	}
}
