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
    var lastHeard: Date = Date.now
    var status = "Applied"
    var nextSteps: String = ""
    
    
    init(item: String = "", lastHeard: Date = Date.now, status: String = "Applied", nextSteps: String = "") {
        self.item = item
        self.lastHeard = lastHeard
        self.status = status
        self.nextSteps = nextSteps
    }
    
}

extension Application {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Application.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Application(item: "Apple", lastHeard: .now, status: "Offer", nextSteps: "This is a test application"))
        container.mainContext.insert(Application(item: "Google", lastHeard: .now, status: "Interviewing", nextSteps: "This is a test application"))
        container.mainContext.insert(Application(item: "Meta", lastHeard: .now, status: "Applying", nextSteps: "This is a test application"))
        return container
    }
}
