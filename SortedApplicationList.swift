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
                    Text(application.item)
                }
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    NavigationStack {
        SortedApplicationList()
    }
}
