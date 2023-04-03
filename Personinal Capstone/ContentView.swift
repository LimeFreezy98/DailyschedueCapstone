//
//  ContentView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/2/23.
//a

import SwiftUI
import UserNotifications
struct ContentView: View {

    @State var eventStorage = Events.events
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
    func eventBinding(at index: Int) -> Binding<Event> {
        .init {
            eventStorage[index]
        } set: { newEvent in
            eventStorage[index] = newEvent
            Events.events = eventStorage
            Events.saveEvents(newEvent: nil)
        }

    }
    
    var body: some View {
        
        
        
        NavigationView {
            
            List {
                ForEach(0..<eventStorage.count, id: \.self) { index in
                    NavigationLink {
                        if editMode == .inactive {
                            DailyView(localEvent: eventBinding(at: index))
                        } else {
                            AddEditView(events: $eventStorage, isEditMode: true, eventId: eventStorage[index].id)
                        }
                    } label: {
                        ScheduleCell(event: eventBinding(at: index))
                    }

//                    NavigationLink(destination: DailyView(localEvent: event)) {
//  bug  cause extra cells
//                    }
                }
                .onDelete(perform: { indexSet in
                    // Handle deletion logic here
                    eventStorage.remove(atOffsets: indexSet)
                    Events.events = eventStorage
                    Events.saveEvents(newEvent: nil)
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
            .onAppear(perform: {
                Events.loadEvents()
                eventStorage = Events.events
            })
        }

        
    }
}

  struct ScheduleCell: View {
      @State private var notificationEnabled = false
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
      }
  }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(eventStorage: Events.events)
    }
}





