//
//  RegistrationView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.05.2023.
//

import SwiftUI

struct RegistrationView: View {
	@State private var email: String = ""
	@State private var password: String = ""
	@State private var repeatPassword: String = ""
	@State private var showingPolicySheet = false
	
	var body: some View {
		NavigationStack {
			VStack {
				Image("Login")
					.resizable()
					.scaledToFit()
				Text("Создание учетной записи")
					.font(.title)
					.bold()
				
				VStack(spacing: 10) {
					CustomTextEdit(placeholder: "Электронная почта", text: $email)
					CustomTextEdit(placeholder: "Пароль", text: $password)
					CustomTextEdit(placeholder: "Повторите пароль", text: $repeatPassword)
				}
				
				Button {
					
				} label: {
					Text("Зарегистрироваться")
						.font(.title3)
						.foregroundColor(Color(.systemBackground))
						.padding()
						.background {
							Capsule()
								.fill(Color(.label))
						}
				}
				.buttonStyle(ScaleButtonStyle())
				.padding(.top)
				
				Spacer()
				
				Button {
					showingPolicySheet.toggle()
				} label: {
					Text("Политика конфиденциальности")
						.font(.subheadline)
				}
			}
			.padding()
		}
		.sheet(isPresented: $showingPolicySheet) {
			PrivacyPolicySheet()
		}
	}
}

struct PrivacyPolicySheet: View {
	@Environment(\.dismiss) var dismiss
		
	var body: some View {
		NavigationStack {
			VStack {
				Text("Бла бла бла бла бла бла")
			}
			.toolbar {
				ToolbarItem {
					Button("Готово") {
						dismiss()
					}
				}
			}
		}
	}
}

struct RegistrationView_Previews: PreviewProvider {
	static var previews: some View {
		RegistrationView()
	}
}
