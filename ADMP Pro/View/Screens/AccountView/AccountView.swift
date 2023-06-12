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
				HeaderView()
				ScrollView(showsIndicators: false) {
					
				}
				.padding(.horizontal, 15)
			}
			.navigationTitle("Профиль")
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
						
						Divider()
						Button(role: .destructive) {
							
						} label: {
							HStack {
								Text("Выход")
								Spacer()
								Image(systemName: "rectangle.portrait.and.arrow.right")
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
				Text("Добро пожаловать")
				Text("Иван Ровков")
					.font(.system(size: 25, weight: .bold))
				Text("Pro+")
					.font(.system(size: 20, weight: .semibold))
			}
			
			Spacer()
			
			NavigationLink(destination: SubscriptionView()) {
				Text("Подписка")
					.padding(10)
					.foregroundColor(Color(.systemGroupedBackground))
					.background(Color(.label))
					.clipShape(Capsule())
			}
			.buttonStyle(ScaleButtonStyle())
		}
		.padding()
	}
}

struct SheetView: View {
	@EnvironmentObject var appSettings: AppStore
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.dismiss) var dismiss
	
	@State private var alertIsShowed = false
	
	var body: some View {
		NavigationStack {
			VStack {
				VStack(alignment: .leading) {
					Text("Токен")
						.bold()
					Text("Ваш токен в можете найти на панеле управления Wilberries в разделе \"Раздел\" ")
						.foregroundColor(.gray)
						.font(.system(size: 15))
                    TextField("Токен Wilberries", text: appSettings.$wbToken)
						.padding(10)
						.background(colorScheme == .dark ?
												Color.init(.systemGray5) :
												Color.init(.systemGray6))
						.clipShape(Capsule())
				}
				
				Spacer()
				
				Button {
					alertIsShowed = true
				} label: {
					Text("Удалить учетную запись")
						.foregroundColor(.red)
				}
			}
			.padding(.horizontal)
			.toolbar {
				ToolbarItem {
					Button("Готово") {
						dismiss()
					}
				}
			}
			.alert(isPresented: $alertIsShowed) {
				Alert(title: Text("Удаление учетной записи"),
							message: Text("Ваша учетная запись будет удалена без возможности восстановления, вы уверены, что хотите удалить ее?"),
							primaryButton: .destructive(Text("Удалить")),
							secondaryButton: .default(Text("Отмена")))
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
