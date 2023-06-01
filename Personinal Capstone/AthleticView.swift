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
    var name: String
    var duration: Int
    var isChecked: Bool
    var notificationEnabled: Bool = false
}

struct AthleticView: View {
    
    @State private var activities: [AthleticActivity] = [
//        AthleticActivity(id: "1", name: "Running", duration: 30, isChecked: false),
//        AthleticActivity(id: "2", name: "Weightlifting", duration: 45, isChecked: false),
//        AthleticActivity(id: "3", name: "Yoga", duration: 60, isChecked: false)
    ]
    
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
        }
    }
    
    private func getIndex(for activity: AthleticActivity) -> Int {
        if let index = activities.firstIndex(where: { $0.id == activity.id }) {
            return index
        }
        return 0
    }
    
    private func deleteActivities(at offsets: IndexSet) {
        activities.remove(atOffsets: offsets)
    }
    
    private func addActivity(activity: AthleticActivity) {
        activities.append(activity)
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
                Text(activity.name)
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
    }
}

//struct AthleticView_Previews: PreviewProvider {
//    static var previews: some View {
//        AthleticView()
//    }
//}
