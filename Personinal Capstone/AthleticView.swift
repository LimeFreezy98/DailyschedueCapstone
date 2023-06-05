//
//  AthleticView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/31/23.
//

import SwiftUI
import UserNotifications

struct AthleticActivity: Identifiable {
    var id: String
    var title: String
    var duration: Int
    var isChecked: Bool
    var notificationEnabled: Bool = false
}

struct AthleticView: View {
//    @Binding var athleyicStorage: Event
    @State private var activities: [AthleticActivity] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities) { activity in
                    AthleticListCell(activity: $activities[getIndex(for: activity)])
                }
                .onDelete(perform: deleteActivities)
            }
            .navigationBarTitle("Athletic")
            .navigationBarItems(
                trailing: NavigationLink(destination: AddAthleticActivityView(activities: $activities, addActivity: addActivity)) {
                    Image(systemName: "plus")
                }
            )
            .background(Color.blue.opacity(0.2))
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            requestNotificationAuthorization()
        }
    }
    
    private func getIndex(for activity: AthleticActivity) -> Int {
        if let index = activities.firstIndex(where: { $0.id == activity.id }) {
            return index
        }
        return 0
    }
    
    private func deleteActivities(at offsets: IndexSet) {
        let deletedActivityIdentifiers = offsets.map { activities[$0].id }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: deletedActivityIdentifiers)
        activities.remove(atOffsets: offsets)
    }
    
    private func addActivity(activity: AthleticActivity) {
        activities.append(activity)
        scheduleNotification(for: activity)
    }
    
    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }
    
    private func scheduleNotification(for activity: AthleticActivity) {
        guard activity.notificationEnabled else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Activity Reminder"
        content.body = "It's time for \(activity.title)!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(activity.duration * 60), repeats: false)
        
        let request = UNNotificationRequest(identifier: activity.id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for \(activity.title)")
            }
        }
    }
}

struct AthleticListCell: View {
    @Binding var activity: AthleticActivity
    
    var body: some View {
        HStack {
            Button(action: {
                activity.isChecked.toggle()
            }) {
                Image(systemName: activity.isChecked ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading) {
                Text(activity.title)
                    .foregroundColor(activity.isChecked ? .gray : .primary)
                Text("Duration: \(activity.duration) min")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Toggle(isOn: $activity.notificationEnabled) {
                Text("Notification")
            }
        }
        .padding()
//        .background(activity.isChecked ? Color.green.opacity(0.2) : Color.clear)
    }
}

//struct AthleticView_Previews: PreviewProvider {
//    static var previews: some View {
//        AthleticView()
//    }
//}
