//
//  DetailView.swift
//  ApplicationTracker
//
//  Created by Theodore Utomo on 10/20/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss //Dismisses a screen
    @Environment(\.modelContext) var modelContext
    
    @State var application: Application
    @State private var item = ""
    @State private var dateApplied = Date.now
    @State private var status = ""
    @State private var notes = ""
    
    var body: some View {
        List {
            TextField("Enter application here", text: $item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)

            DatePicker("Date Applied:", selection: $dateApplied)
                .listRowSeparator(.hidden)
            
            VStack (alignment: .leading){
                Text("Status of Application: ")
                
                TextField("Enter Status: ", text: $status)
                    .padding(.top)
                    .listRowSeparator(.hidden)
            }
            
            Text("Notes: ")
                .padding(.top)
                .listRowSeparator(.hidden)
            TextField("Notes: ", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .padding(.top)
                .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
        .onAppear() {
            item = application.item
            dateApplied = application.dateApplied
            status = application.status
            notes = application.notes
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    //Move data from local vars to toDo object
                    application.item = item
                    application.dateApplied = dateApplied
                    application.status = status
                    application.notes = notes
                    modelContext.insert(application)
                    guard let _ = try? modelContext.save() else {
                        print("Save on DetailView did not work!")
                        return
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(application: Application())
            .modelContainer(for: Application.self, inMemory: true)
    }
}
