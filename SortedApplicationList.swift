//
//  SortedApplicationList.swift
//  ApplicationTracker
//
//  Created by Theodore Utomo on 10/20/24.
//

import SwiftUI
import SwiftData

struct SortedApplicationList: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var applications: [Application]
    
    var body: some View {
        List {
            ForEach(applications) { application in
                NavigationLink {
                    DetailView(application: application)
                } label: {
                    VStack(alignment: .leading){
                        Text(application.item)
                        
                        Text("\(application.status) - \(application.nextSteps)")
                            .font(.caption)
                        
                        Text("Last heard - \(application.lastHeard.formatted(.dateTime.year().month().day()))")
                            .font(.caption)
                    }
                }
            }
        }
        .listStyle(.plain)
        
    }
}


#Preview {
    NavigationStack {
        SortedApplicationList()
            .modelContainer(Application.preview)
    }
}
