//
//  ADMP_ProApp.swift
//  ADMP Pro
//
//  Created by Иван Ровков on 19.04.2023.
//

import SwiftUI

@main
struct ADMP_ProApp: App {
    
    private let appSettings = AppStore()

    var body: some Scene {
        WindowGroup {
            if appSettings.isAuth {
                ContentView()
                    .environmentObject(appSettings)
            } else {
                LoginView()
                    .environmentObject(appSettings)
            }
        }
    }
}
