//
//  EPIC_RPSApp.swift
//  EPIC_RPS
//
//  Created by Dmitriy Eliseev on 09.06.2024.
//

import SwiftUI

@main
struct EPIC_RPSApp: App {
    @StateObject var epicManager = GameManager()
    var body: some Scene {
        WindowGroup {
            SplashView(epicManager: epicManager)
        }
    }
}
