//
//  AccountView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct AccountView: View {
	
	
	
	var body: some View {
		NavigationStack {
			Section {
				ScrollView(showsIndicators: false) {
					
					VStack {
						
					}
					
					ForEach(1..<15) { index in
						Text("Информация - \(index)")
							.padding(.bottom, 15)
					}
				}
			} header: {
				HeaderView()
			}
			.padding()
			.navigationTitle("Мой Аккаунт")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct HeaderView: View {
	var body: some View {
		HStack {
			VStack {
				Text("Иван Ровков")
					.font(.system(size: 25))
				Text("Текущая подписка")
			}
			
			Spacer()
			
			NavigationLink(destination: SubscriptionView()) {
				Text("Улучшить")
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color(.secondarySystemGroupedBackground))
	}
}

struct AccountView_Previews: PreviewProvider {
	static var previews: some View {
		AccountView()
	}
}
