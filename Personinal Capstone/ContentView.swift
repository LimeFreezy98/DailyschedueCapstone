//
//  ContentView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/2/23.
//a

import SwiftUI

struct ContentView: View {

    @State var eventStorage = Events()
    
    /*
     create test event
    var newEvent = Event(title: "test title", date: Date())
    eventStorage.events.append(newEvent)
    */
    var body: some View {
        
        
        
        NavigationView {
            
            List {
                ForEach($eventStorage.events) { event in
                    NavigationLink(destination: DailyView(localEvent: event)) {
                        ScheduleCell(event: event)
                    }
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





