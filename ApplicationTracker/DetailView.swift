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
    @State private var lastHeard = Date.now
    @State private var status = ""
    @State private var nextSteps = ""
    
    let statusOptions: [String] = ["Applying", "Applied", "Heard Back - Online Assessment", "Heard Back - Scheduled Interview", "Interviewing", "Offer", "Rejected"]
    
    @FocusState private var itemFieldIsFocused: Bool
    @FocusState private var nextStepsFieldIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Enter application here", text: $item)
                    .font(.title)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical)
                    .listRowSeparator(.hidden)
                    .focused($itemFieldIsFocused)
                    .onSubmit {
                        itemFieldIsFocused = false
                    }
                
                
                DatePicker("Date of Most Recent Update:", selection: $lastHeard, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .listRowSeparator(.hidden)
                    .fontWeight(.medium)
                
                VStack (alignment: .leading){
                    
                    Text("Application Status")
                        .fontWeight(.medium)
                    
                    Picker("", selection: $status) {
                        ForEach(statusOptions, id: \.self) { status in
                                Text(status)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .labelsHidden()
                    .tint(.black)
                }
                .padding(.top)
                .listRowSeparator(.hidden)
                
                Text("Next Steps: ")
                    .padding(.top)
                    .listRowSeparator(.hidden)
                    .fontWeight(.medium)
                TextField("Next Steps: ", text: $nextSteps, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .padding(.top)
                    .listRowSeparator(.hidden)
                    .focused($nextStepsFieldIsFocused)
                    .onSubmit {
                        nextStepsFieldIsFocused = false
                    }
                
            }
            .listStyle(.plain)
            .onAppear() {
                item = application.item
                lastHeard = application.lastHeard
                status = application.status
                nextSteps = application.nextSteps
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
                        application.item = item
                        application.lastHeard = lastHeard
                        application.status = status
                        application.nextSteps = nextSteps
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
}

#Preview {
    NavigationStack {
        DetailView(application: Application())
            .modelContainer(for: Application.self, inMemory: true)
    }
}
