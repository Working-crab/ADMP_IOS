//
//  CircullarLoadingView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 27.04.2023.
//

import SwiftUI

struct EmojiLoadingView: View {
	
	@State var size: CGFloat
	@State private var currentEmoji: String = "😬"
	@State private var index: Int = 0
	@State private var isChanged = true
	
	private let emojis = ["🙂","😅","😌","😬","🥱","😴"]
	
	var body: some View {
		Group {
			if isChanged {
				Text(currentEmoji)
			} else {
				Text(currentEmoji)
			}
		}
		.font(.system(size: size))
		.transition(.push(from: .trailing))
		.onAppear {
			startTimer()
		}
	}
	
	private func startTimer() {
		Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
			withAnimation(.easeInOut(duration: 1)) {
				index += 1
				if index >= emojis.count {
					index = 0
				}
				currentEmoji = emojis[index]
				isChanged.toggle()
			}
		}
	}
}

struct EmojiLoadingView_Previews: PreviewProvider {
	 static var previews: some View {
		 EmojiLoadingView(size: 80)
	 }
}
