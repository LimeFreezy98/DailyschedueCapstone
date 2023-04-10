//
//  SecondAddEditView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/15/23.
//

import SwiftUI

struct SecondAddEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var dailyTitle = ""
    @State private var dailyStartDate = Date()
    @State private var dailyEndDate = Date()
    @State private var showStartTimePicker = false
    @State private var showEndTimePicker = false
    @Binding var logs: Event
    @State var editMode = false
    @State var logID: Int

    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Title:")
                                .font(.headline)
                            TextField("Enter title", text: $dailyTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding(.bottom)
                    }
                }
                

                
                Section {
                    Button(action: {
                        
                        self.showStartTimePicker.toggle()
                    }) {
                        HStack {
                            Text("Start:")
                                .font(.headline)
                            Spacer()
                            Text(timeString(date: dailyStartDate))
                                .foregroundColor(.gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                    if showStartTimePicker {
                        DatePicker("Pick a start time", selection: $dailyStartDate, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                }
                Section {
                    Button(action: {
                        self.showEndTimePicker.toggle()
                    }) {
                        HStack {
                            Text("End:")
                                .font(.headline)
                            Spacer()
                            Text(timeString(date: dailyEndDate))
                                .foregroundColor(.gray)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    if showEndTimePicker {
                        DatePicker("Pick an end time", selection: $dailyEndDate, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                    }
                }
                
                Section {
                    Button(action: {
                        if editMode  {
                            guard
                                let logIndex = logs.logs?.firstIndex(where: { log in
                                log.id == logID
                            }),
                                var logCopy = logs.logs?[logIndex]
                            else { fatalError() }
                            
                            
                            logCopy.title = dailyTitle
                            logCopy.startTime = dailyStartDate
                            logCopy.endTime = dailyEndDate
                            
                            // update binding
                            logs.logs?[logIndex] = logCopy
                            
                            for index in Events.events.indices {
                                if Events.events[index].id == logs.id {
                                    // also update singleton because binding isn't propagating
                                    Events.events[index].logs?[logIndex] = logCopy
                                    Events.saveEvents(newEvent: nil)
                                }
                            }

                        }
                        else {
                            let newLog = Log(id: Int(Date().timeIntervalSince1970), title: self.dailyTitle, startTime: self.dailyStartDate, endTime: self.dailyEndDate)
                           //                         Save task and dismiss view
                           //                        logs.logs?.append(newLog)
                                                   //logs.addlog(log: newLog)
                                                   
                                                   
                                                   for index in Events.events.indices {
                                                       
                                                       // Get the event that the log belongs to
                                                       if Events.events[index].id == logs.id {
                                                           
                                                           // if there are no log matches
                                                           // handle there being no logs
                                                           if Events.events[index].logs == nil {
                                                               Events.events[index].logs = [newLog]
                                                           } else {
                                                               Events.events[index].logs?.append(newLog)
                                                           }
                                                           Events.saveEvents(newEvent: nil)
                                                           break
                                                       }
                                                   }
                        }
                        //create a log object & add it to current event's log array eventStorage.events
                        
                       
                        
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
            .navigationBarTitle("Add/Edit Daily")
        }
    }
    private func timeString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

//struct SecondEvents {
//    dailytitle is textfield
//    $dailyTitle
//}
