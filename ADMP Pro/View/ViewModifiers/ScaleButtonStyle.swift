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
			.scaleEffect(configuration.isPressed ? 0.96 : 1)
			.animation(
					Animation
						.linear(duration: 0.1)
						.speed(1),
					value: configuration.isPressed
			)
	}
}

struct TestView: View {
	var body: some View {
		VStack {
			Button {} label: {
				Text("Подписка")
					.padding(10)
					.foregroundColor(Color(.systemGroupedBackground))
					.background(Color(.label))
					.clipShape(Capsule())
			}
			.buttonStyle(ScaleButtonStyle())
		}
	}
}

struct TestView_Previews: PreviewProvider {
	static var previews: some View {
		TestView()
			.previewLayout(.sizeThatFits)
			.padding()
	}
}
