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
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        VStack {
                            Image(.login)
                                .resizable()
                                .scaledToFit()
                            Text("Регистрация")
                                .font(.title)
                                .bold()
                            Text("Используйте учетную запись для сохранения всей своей торговой статистике и доступа к уникальным функциям приложения!")
                                .padding(.top, 2)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            CustomTextEdit(placeholder: "Электронная почта", text: $email)
                            CustomTextEdit(placeholder: "Пароль", text: $password)
                            CustomTextEdit(placeholder: "Повторите пароль", text: $repeatPassword)
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Создать учетную запись")
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
                    .frame(minHeight: geometry.size.height)
                }
                .frame(width: geometry.size.width)
                .scrollIndicators(.hidden)
            }
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
