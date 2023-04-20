//
//  AdvertisingView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 20.04.2023.
//

import SwiftUI

struct AdvertisingView: View {
	
	
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(1..<25) { index in
					VStack(alignment: .leading) {
						Text("Компания №\(index)")
							.bold()
						Text("Подробная информация рекламной компании")
					}
				}
			}
			.navigationTitle("Рекламные компании")
		}
	}
}

struct AdvertisingView_Previews: PreviewProvider {
	static var previews: some View {
		AdvertisingView()
	}
}
