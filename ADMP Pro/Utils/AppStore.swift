//
//  AppSettings.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 21.04.2023.
//

import Foundation
import SwiftUI

class AppStore: ObservableObject {
		
	@AppStorage("WBToken") var wbToken: String = ""
}
