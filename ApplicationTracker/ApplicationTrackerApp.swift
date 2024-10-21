//
//  ApplicationTrackerApp.swift
//  ApplicationTracker
//
//  Created by Theodore Utomo on 10/20/24.
//

import SwiftUI
import SwiftData

@main
struct ApplicationTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ApplicationView()
                .modelContainer(for: Application.self)
        }
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
