//
//  File.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 12.06.2023.
//

import Foundation
import SwiftUI

class AppStore: ObservableObject {
        
    @AppStorage("WBToken") var wbToken: String = ""
    @AppStorage("IsAuth") var isAuth: Bool = false
}

