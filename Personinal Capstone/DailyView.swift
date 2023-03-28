//
//  DailyView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/15/23.
//

import SwiftUI

struct DailyView: View {
    
//    var event Event
    // declare Event
    @Binding var localEvent: Event
    
    @State private var startTime = Date()
    @State private var endTime = Date()
//    @Binding var
//    var event: Event
    
    
    var body: some View {
        NavigationView {
            if let logs = localEvent.logs {
                var localLogs = logs
                List {
                    ForEach(localLogs) { log in
                        DailyCell(log: log)
                    }
                    .onDelete(perform: { indexSet in
    //                     Handle deletion logic here:
                        
                        
                        localLogs.remove(atOffsets: indexSet)
                        self.localEvent.logs = localLogs
                    })
                    .overlay(
                        Group {
                            if localLogs.isEmpty {
                                Text("No data")
                            } else {
                                EmptyView()
                            }
                        }
                    )
                }
            }
//            List {
//                ForEach(localEvent.logs ?? [Log(title: "placeholder", startTime: Date(), endTime: Date())]) { index in
//                    DailyCell()
//                }
//                .onDelete(perform: { indexSet in
////                     Handle deletion logic here:
//
//
//                    localEvent.logs.remove(atOffsets: indexSet)
//                })
//                .overlay(
//                    Group {
//                        if localEvent.logs.isEmpty {
//                            Text("No data")
//                        } else {
//                            EmptyView()
//                        }
//                    }
//                )
//            }
        }
        
        .navigationBarTitle(Text("Daily"))
        .navigationBarItems(
            trailing:
                NavigationLink(destination: SecondAddEditView(logs: $localEvent)) {
                    Image(systemName: "plus")
                }
        )
    }
}


struct DailyCell: View {
    @State private var notificationEnabled = false
    var log: Log
    
    
    var body: some View {
           VStack(alignment: .leading) {
               HStack {
                   Text(log.title)  // Display the log's title
                       .font(.headline)
                   Spacer()
                   Toggle(isOn: $notificationEnabled) {
                       Text("Notifications")
                   }
               }
               HStack {
                   Text("Start:")
                       .font(.subheadline)
                   Text(log.startTime, style: .time)  // Display the log's start time
                       .foregroundColor(.gray)
               }
               HStack {
                   Text("End:")
                       .font(.subheadline)
                   Text(log.endTime, style: .time)  // Display the log's end time
                       .foregroundColor(.gray)
               }
           }
       }
   }
