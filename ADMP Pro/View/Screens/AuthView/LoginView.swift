//
//  WelomeView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 23.05.2023.
//

import SwiftUI

struct LoginView: View {
	@State private var email: String = ""
	@State private var password: String = ""
	
	var body: some View {
		NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Spacer()
                        
                        VStack {
                            Image(.welcome)
                                .resizable()
                                .scaledToFit()
                            Text("Добро пожаловать в ADMP Pro!")
                                .font(.title)
                                .bold()
                            Text("Твой лучший советник и помощник по маркетплейсу Wildberries")
                                .padding(.top, 2)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        VStack(spacing: 10) {
                            CustomTextEdit(placeholder: "Электронная почта", text: $email)
                            CustomTextEdit(placeholder: "Пароль", text: $password)
                        }

                        Spacer()
                        
                        VStack {
                            Button {} label: {
                                Text("Войти в учетную запись")
                                    .frame(maxWidth: 280)
                                    .font(.title3)
                                    .foregroundColor(Color(.systemBackground))
                                    .padding()
                                    .background {
                                        Capsule()
                                            .fill(Color(.label))
                                    }
                            }
                            .buttonStyle(ScaleButtonStyle())
                            
                            HStack {
                                Text("Еще не зарегистрированы?")
                                NavigationLink {RegistrationView()} label: {
                                    Text("Регистрация")
                                }
                            }
                            .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(minHeight: geometry.size.height)
                }
                .frame(width: geometry.size.width)
                .scrollIndicators(.hidden)
            }
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
