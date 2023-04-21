//
//  AppSettings.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
	
	@AppStorage("WBToken") var wbToken = ""
	
	static let shared = AppSettings(); private init() {}
}
