//
//  SubscriptionView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct SubscriptionView: View {
		
	var body: some View {
		NavigationStack {
			ScrollView {
				VStack(spacing: 30) {
					ForEach(1..<4) { index in
						Button {
							print(index)
						} label: {
							SubscriptionCardView()
						}
						.buttonStyle(ScaleButtonStyle())
					}
				}
				.padding()
			}
			.navigationTitle("Подписки")
		}
	}
}

struct SubscriptionCardView: View {
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text("Pro+")
				.font(.system(size: 25, weight: .bold))
			Text("Получи безграничный доступ ко всем функциями приложения. Получай уведомления, управляй товарами и просматривай рекламные ставки")
				.font(.system(size: 15))
			HStack {
				Spacer()
				Text("450₽/мес.")
					.font(.system(size: 25, weight: .bold))
			}
		}
		.padding()
		.foregroundColor(.white)
		.background(.black)
		.clipShape(RoundedRectangle(cornerRadius: 25))
		.shadow(color: Color.black.opacity(0.1), radius: 20)
	}
}

struct ScaleButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
			.animation(.linear(duration: 0.1), value: configuration.isPressed)
	}
}

struct SubscriptionView_Previews: PreviewProvider {
	static var previews: some View {
		SubscriptionView()
	}
}
