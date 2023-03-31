//
//  ContentView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/2/23.
//a

import SwiftUI
import UserNotifications
struct ContentView: View {

    @State var eventStorage = Events()
    @State private var editMode: EditMode = .inactive
    @State private var showDetail = false
    /*
     create test event
    var newEvent = Event(title: "test title", date: Date())
    eventStorage.events.append(newEvent)
    */
    var body: some View {
        
        
        
        NavigationView {
            
            List {
                ForEach($eventStorage.events) { event in
                    NavigationLink {
                        if editMode == .inactive {
                            DailyView(localEvent: event)
                        } else {
                            AddEditView(events: $eventStorage)
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
                    eventStorage.events.remove(atOffsets: indexSet)
                })
                .overlay(
                    Group {
                        if eventStorage.events.isEmpty {
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
                trailing: NavigationLink(destination: AddEditView(events: $eventStorage)) {
                    Image(systemName: "plus")
                }
            )
            .environment(\.editMode, $editMode)
        }
    }
}

  struct ScheduleCell: View {
      @State private var notificationEnabled = false
      @Binding var event: Event
      
      var body: some View {
          VStack(alignment: .leading) {
              HStack {
                  Text(event.title)
                      .font(.headline)
                  Spacer()
                  Toggle(isOn: $notificationEnabled) {
                      Text("Notifications")
                  }
              }
              Text("Date:")
              Text(event.date, style: .date)
                  .font(.subheadline)
          }
      }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(eventStorage: eventStorage)
    }
}





