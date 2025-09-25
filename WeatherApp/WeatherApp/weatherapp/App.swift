//
//  App.swift
//  weatherapp
//
//  Created by Jesus Perez on 29/09/2025
//

import SwiftUI
import SwiftData

@main
struct mvvmApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(coordinator)
        }
        .modelContainer(sharedModelContainer)
    }
}

