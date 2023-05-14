//
//  ErrorMessageView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 15.05.2023.
//

import SwiftUI

struct ErrorMessageView: View {
	
	var error: String
	@State var isHapticWorked: Bool = false
	
	var body: some View {
		VStack {
			Text("😓")
				.font(.system(size: 50))
				.padding(.bottom, -10)
			Text("Упс, сломалось")
				.font(.system(size: 20, weight: .semibold))
			Text(error)
				.multilineTextAlignment(.center)
				.foregroundColor(.gray)
		}
		.onAppear {
			if !isHapticWorked {
				Haptic.shared.notify(.error)
				self.isHapticWorked.toggle()
			}
		}
	}
}

struct ErrorMessageView_Previews: PreviewProvider {
	static var previews: some View {
		ErrorMessageView(error: "Текст ошибки")
	}
}
