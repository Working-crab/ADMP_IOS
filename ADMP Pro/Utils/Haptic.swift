//
//  Haptic.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 15.05.2023.
//

import Foundation
import SwiftUI

class Haptic {
	static let shared = Haptic()
	
	private init() {}
	
	func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
		UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
	}
	
	func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
		UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
	}
}
