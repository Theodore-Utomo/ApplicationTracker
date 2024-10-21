//
//  Application.swift
//  ApplicationTracker
//
//  Created by Theodore Utomo on 10/20/24.
//

import Foundation
import SwiftData

@Model
@MainActor
class Application {
    var item: String = ""
    var dateApplied: Date = Date.now
    var status = "Applied"
    var notes: String = ""
    
    init(item: String = "", dateApplied: Date = Date.now, status: String = "Applied", notes: String = "") {
        self.item = item
        self.dateApplied = dateApplied
        self.status = status
        self.notes = notes
    }
    
}

extension Application {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Application.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Application(item: "Apple", dateApplied: .now, status: "Applied", notes: "This is a test application"))
        container.mainContext.insert(Application(item: "Google", dateApplied: .now, status: "Applied", notes: "This is a test application"))
        container.mainContext.insert(Application(item: "Meta", dateApplied: .now, status: "Applied", notes: "This is a test application"))
        return container
    }
}
