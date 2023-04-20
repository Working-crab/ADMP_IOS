//
//  SubscriptionView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct SubscriptionView: View {
	
	private var subscriptions = ["Basic", "Pro", "Premium"]
	
	var body: some View {
		NavigationStack {
			ScrollView {
				VStack(spacing: 20) {
					ForEach(subscriptions, id: \.self) { sub in
						HStack {
							VStack(alignment: .leading) {
								Text("\(sub)")
									.bold()
								Spacer()
								Text("Краткое описание подписки.\nЕе преимущества:")
								ForEach(1..<4) { index in
									Text(" • Преимущество \(index)")
								}
							}
							
							Spacer()
							
							VStack {
								Spacer()
								if sub == "Basic" {
									Text("Бесплатно")
								} else {
									Text("200 Руб.")
								}
							}
						}
					}
				}
				.padding()
			}
			.navigationTitle("Подписки")
		}
	}
}

struct SubscriptionView_Previews: PreviewProvider {
	static var previews: some View {
		SubscriptionView()
	}
}
