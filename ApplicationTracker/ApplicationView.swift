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

    var body: some View {
        NavigationStack {
            SortedApplicationList()
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
                }
        }
    }
}

#Preview {
    NavigationStack {
        ApplicationView()
            .modelContainer(Application.preview)
    }
}
