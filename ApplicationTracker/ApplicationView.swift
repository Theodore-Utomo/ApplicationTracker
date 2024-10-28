//
//  ContentView.swift
//  ApplicationTracker
//
//  Created by Theodore Utomo on 10/20/24.
//

import SwiftUI
import SwiftData


struct ApplicationView: View {
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            SortedApplicationList(sortSelection: sortSelection)
                .navigationTitle("Applications")
                .navigationBarTitleDisplayMode(.automatic)
                .sheet(isPresented: $sheetIsPresented) {
                    DetailView(application: Application())
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetIsPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Picker("", selection: $sortSelection) {
                            ForEach(SortOption.allCases, id: \.self) { sortOrder in
                                Text(sortOrder.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                }
        }
    }
}

enum SortOption: String, CaseIterable{
    case asEntered = "Unordered"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case heard = "Heard From"
}

struct SortedApplicationList: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var applications: [Application]
    
    @State var searchText = ""
    
    private var filteredApplications: [Application] {
        if searchText.isEmpty {
            return applications
        } else {
            return applications.filter { application in
                application.item.capitalized.contains(searchText.capitalized)
            }
        }
    }
    
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .asEntered:
            _applications = Query()
        case .alphabetical:
            _applications = Query(sort: \.item)
        case .chronological:
            _applications = Query(sort: \.lastHeard)
        case .heard:
            _applications = Query(filter: #Predicate {!$0.status.contains("Appl")})
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredApplications) { application in
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
        .searchable(text: $searchText)
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ApplicationView()
            .modelContainer(Application.preview)
    }
}
