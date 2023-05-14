//
//  AdvertisingView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct AdvertisingView: View {
	
	@EnvironmentObject var appSettings: AppSettings
	
	var body: some View {
		NavigationStack {
			VStack(spacing: 10) {
				if appSettings.wbToken.isEmpty {
					Text("😓")
						.font(.system(size: 50))
						.padding(.bottom, -10)
					Text("Ой-ой")
						.font(.system(size: 20, weight: .semibold))
					Text("Чтобы просматривать свои рекламные компании введите токен Wilberries в настройках аккаунта")
						.multilineTextAlignment(.center)
				} else {
					ScrollView(showsIndicators: false) {
						ForEach(1..<25) { index in
							VStack(alignment: .leading) {
								Text("Компания №\(index)")
									.bold()
								Text("Подробная информация рекламной компании")
							}
						}
					}
				}
			}
			.padding(.horizontal)
			.navigationTitle("Рекламные компании")
		}
	}
}

struct AdvertisingView_Previews: PreviewProvider {
	static var previews: some View {
		AdvertisingView()
			.environmentObject(AppSettings())
	}
}
