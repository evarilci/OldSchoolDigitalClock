//
//  neonWatchApp.swift
//  neonWatch
//
//  Created by Eymen Varilci on 23.01.2025.
//

import SwiftUI
import SwiftData

@main
struct neonWatchApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color.black)
        }
        
       
    }
}
