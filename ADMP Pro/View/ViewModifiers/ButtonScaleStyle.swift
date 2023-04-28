//
//  ButtonScaleView.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 27.04.2023.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.95 : 1)
			.animation(.linear(duration: 0.1), value: configuration.isPressed)
	}
}
