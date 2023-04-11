//
//  ContentView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/2/23.
//a

import SwiftUI
import UserNotifications
struct ContentView: View {

    @Binding var eventStorage: [Event]
    @State private var editMode: EditMode = .inactive
    @State private var showDetail = false

    /*
     create test event
    var newEvent = Event(title: "test title", date: Date())
    eventStorage.events.append(newEvent)
    */
    
    
//    func saveEvent() {
//        let event = Event(id: Int(Date().timeIntervalSince(<#T##date: Date##Date#>)))
//    }
  
    
    var body: some View {
        
        
        
        NavigationView {
            
            List {
                ForEach($eventStorage) { event in
                    NavigationLink {
                        if editMode == .inactive {
                            DailyView(localEvent: event)
                        } else {
                            AddEditView(events: $eventStorage, isEditMode: true, eventId: event.id)
                        }
                    } label: {
                        ScheduleCell(event: event)
                    }

//                    NavigationLink(destination: DailyView(localEvent: event)) {
//  bug  cause extra cells
//                    }
                }
                .onDelete(perform: { indexSet in
                    // Handle deletion logic here
                    eventStorage.remove(atOffsets: indexSet)
//                    Events.events = eventStorage
//                    Events.saveEvents(newEvent: nil)
                })
                .overlay(
                    Group {
                        if eventStorage.isEmpty {
                            Text("No data")
                        } else {
                            EmptyView()
                        }
                    }
                )
            }
            .navigationBarTitle(Text("Schedule"))
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink(destination: AddEditView(events: $eventStorage, isEditMode: false, eventId: 0)) {
                    Image(systemName: "plus")
                }
            )
            .environment(\.editMode, $editMode)
//            .onAppear(perform: {
//                Events.loadEvents()
//                eventStorage = Events.events
//            })
        }

        
    }
}

struct ScheduleCell: View {
    @Binding var event: Event
    @State private var showAlert = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(event.title)
                    .font(.headline)
                Spacer()
                Toggle(isOn: $event.notificationEnabled) {
                    Text("Notifications")
                }
            }
            Text("Date:")
            Text(event.date, style: .date)
                .font(.subheadline)
        }
        .onChange(of: event.notificationEnabled) { newValue in
            if newValue {
                addNotification(title: event.title)
            } else {
                //TODO: remove notification
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
            
            guard event.notificationEnabled else {
                return  // If notifications are not enabled, return early
            }
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = "today is your  \(event.title)"
            
            print("Start time: \(event.date)")
            
            //            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let triggerDateComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: event.date)
            print("Components year: \(triggerDateComponents.year) month: \(triggerDateComponents.month) day: \(triggerDateComponents.day) hour: \(triggerDateComponents.hour) minute: \(triggerDateComponents.minute) second: \(triggerDateComponents.second)")
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
           
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
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(eventStorage: .constant([]))
        }
    }
    




