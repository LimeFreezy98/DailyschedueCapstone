//
//  DailyView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/15/23.
//

import SwiftUI
import UserNotifications
import UIKit
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
                        NavigationLink {
                            SecondAddEditView(logs: $localEvent, logID: log.id)
                        } label: {
                            DailyCell(event: $localEvent, log: log)
                        }
                    }
                    
                    .onDelete(perform: { indexSet in
    //                     Handle deletion logic here:
                        
//                        var localLogs = logs
                        localLogs.remove(atOffsets: indexSet)
                        print(localEvent.logs)
                        self.localEvent.logs = localLogs
                        print(localEvent.logs)
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
        }
        .onAppear(perform: {
            Events.loadEvents()
            for index in Events.events.indices {
                if Events.events[index].id == localEvent.id {
                    localEvent = Events.events[index]
                }
            }
           
        })
        .navigationBarTitle(Text("Daily"))
        .navigationBarItems(
            trailing:
                NavigationLink(destination: SecondAddEditView(logs: $localEvent, logID: 0)) {
                    Image(systemName: "plus")
                }
        )
    }
    
}


struct DailyCell: View {
    @State private var notificationEnabled = false
    
    @Binding var event: Event
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
                Spacer()
                Button(action: {
                    addNotification(title: "It's time to do \(log.title)!")
                }) {
                    
                }
            }
            HStack {
                Text("End:")
                    .font(.subheadline)
                Text(log.endTime, style: .time)  // Display the log's end time
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    addNotification(title: "Your \(log.title) is done for now.")
                }) {
                    
                }
            }
        } .onTapGesture {
            let secondaddeditview = SecondAddEditView(logs: $event, logID: log.id)
        }
    }
    
    func addNotification(title: String) {
        guard notificationEnabled else {
            return  // If notifications are not enabled, return early
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
