//
//  _025_iOS_Scouting_AppApp.swift
//  2025-iOS-Scouting-App
//
//  Created by Jason Kaip on 1/25/25.
//

import SwiftUI

@main
struct Reefscape_iOS_Scouting_AppApp: App {
    let persistenceController = PersistenceController.shared
    @State private var gameHistory: [GameData] = []
    @State private var resetForm: Bool = false
    @State private var showWelcomeScreen = true

    var body: some Scene {
        WindowGroup {
            if showWelcomeScreen {
                WelcomeScreen(showWelcomeScreen: $showWelcomeScreen)
            } else {
                MainMenuView(gameHistory: $gameHistory, resetForm: $resetForm)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
