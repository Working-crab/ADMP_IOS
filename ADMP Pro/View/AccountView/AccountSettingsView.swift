//
//  ProfileSettingsView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import SwiftUI

struct AccountSettingsView: View {
	
	@ObservedObject var settings = AppSettings.shared
	
	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack {
				HStack {
					Text("Токен:")
					TextField("Токен Wildberries", text: settings.$wbToken)
				}
			}
			.padding()
		}
		.navigationTitle("Настройки аккаунта")
	}
}

struct AccountSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		AccountSettingsView()
	}
}
