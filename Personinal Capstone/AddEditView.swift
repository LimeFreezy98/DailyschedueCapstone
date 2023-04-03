//
//  AddEditView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/8/23.
//

//import Foundation
import SwiftUI

struct AddEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var taskTitle = ""
    @State private var taskDate = Date()
    @State private var showDatePicker = false
    @Binding var events: [Event]
    var isEditMode: Bool
    var eventId: Int
//    @State private var editdatastore
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Title:")
                                .font(.headline)
                            TextField("Enter title", text: $taskTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.bottom)
                    }
                }
                
                Section {
                    Button(action: {
                        self.showDatePicker.toggle()
                    }) {
                        HStack {
                            Text("Date:")
                                .font(.headline)
                            Spacer()
                            Text(dateString(date: taskDate))
                                .foregroundColor(.gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    if showDatePicker {
                        DatePicker("Pick a date", selection: $taskDate, in: Date()..., displayedComponents: [.date])
                            .datePickerStyle(WheelDatePickerStyle())
                        
                        
                    }
                }
                
                Section {
                    Button(action: {
                        // Create event object and add to events array on
                        let newEvent = Event(id: Int(Date().timeIntervalSince1970), title: self.taskTitle, date: self.taskDate, logs: nil)
                        //                            eventStorage.events.append(newEvent)
                        //events.events.append(newEvent)
                        if isEditMode {
                            for index in Events.events.indices {
                                if Events.events[index].id == eventId {
                                    Events.events[index] = newEvent
                                    Events.saveEvents(newEvent: nil)
                                }
                            }
                        } else {
                            Events.saveEvents(newEvent: newEvent)
                        }
                        // Save task and dismiss view
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                            .fontWeight(.bold)
                            .padding(.all, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 44)
                }
            }
            .padding()
            .navigationBarTitle("Add/Edit Task")
            //                .navigationBarItems(trailing:
            //                    Button(action: {
            //                        // Save task and dismiss view
            //                        self.presentationMode.wrappedValue.dismiss()
            //                    }) {
            //                        Text("Done")
            //                    }
            //                )
        }
    }
    
    private func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    
    
}
