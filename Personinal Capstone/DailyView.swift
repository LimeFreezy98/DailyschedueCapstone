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
            List {
                ForEach($localEvent.logs) { log in
                    NavigationLink {
                        SecondAddEditView(logs: $localEvent, editMode: true, logID: log.id)
                    } label: {
                        DailyCell(event: $localEvent, log: log)
                    }
                }
                
                .onDelete(perform: { indexSet in
                    //                     Handle deletion logic here:
                    
                    //                        var localLogs = logs
                    localEvent.logs.remove(atOffsets: indexSet)
                    //remind
                })
                .overlay(
                    Group {
                        if localEvent.logs.isEmpty {
                            Text("No data")
                        } else {
                            EmptyView()
                        }
                    }
                )
            }
        }
        //        .onAppear(perform: {
        //            Events.loadEvents()
        //            for index in Events.events.indices {
        //                if Events.events[index].id == localEvent.id {
        //                    localEvent = Events.events[index]
        //                }
        //            }
        //
        //        })
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
    @Binding var event: Event
    @Binding var log: Log
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(log.title)  // Display the log's title
                    .font(.headline)
                Spacer()
                Toggle(isOn: $log.notificationEnabled) {
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
        }
        .onTapGesture {
            let secondaddeditview = SecondAddEditView(logs: $event, logID: log.id)
        }
        .onChange(of: log.notificationEnabled) { newValue in
            if newValue {
                addNotification(title: log.title)
            } else {
                //TODO: Remove notification
            }
        }
    }
    
    
    func addNotification(title: String) {
        authorizeIfNeeded { (granted) in
            guard granted else {
                //                DispatchQueue.main.async {
                //                    completion(updatedBill)
                //                }
                
                return
            }
            
            guard log.notificationEnabled else {
                return  // If notifications are not enabled, return early
            }
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = "its time to do \(log.title)"
            
            print("Start time: \(log.startTime)")
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let triggerDateComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: log.startTime)
            print("Components year: \(triggerDateComponents.year) month: \(triggerDateComponents.month) day: \(triggerDateComponents.day) hour: \(triggerDateComponents.hour) minute: \(triggerDateComponents.minute) second: \(triggerDateComponents.second)")
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
            let content2 = UNMutableNotificationContent()
            content2.title = title
            content2.body = "the \(log.title) is over for now!"
            print("endtime: \(log.endTime)")
            
            let triggerDateComponents2 = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: log.endTime)
            print("Components year: \(triggerDateComponents2.year) month: \(triggerDateComponents2.month) day: \(triggerDateComponents2.day) hour: \(triggerDateComponents2.hour) minute: \(triggerDateComponents2.minute) second: \(triggerDateComponents2.second)")
            let trigger2 = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents2, repeats: false)
            let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: content2, trigger: trigger2)
         
            UNUserNotificationCenter.current().add(request2)
        }
        
        func authorizeIfNeeded(completion: @escaping (Bool) -> ()) {
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.getNotificationSettings { (settings) in
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    completion(true)
                    
                case .notDetermined:
                    notificationCenter.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, _) in
                        completion(granted)
                    })
                    
                case .ephemeral:
                    // only available to app clips
                    completion(false)
                    
                case .denied:
                    completion(false)
                    
                @unknown default:
                    completion(false)
                }
            }
        }
    }
}
