//
//  _025_iOS_Scouting_AppApp.swift
//  2025-iOS-Scouting-App
//
//  Created by Jason Kaip on 1/25/25.
//

import SwiftUI

@main
struct _025_iOS_Scouting_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
