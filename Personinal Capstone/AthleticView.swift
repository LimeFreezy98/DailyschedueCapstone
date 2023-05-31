//
//  AthleticView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/31/23.
//

import SwiftUI

struct AthleticActivity: Identifiable {
    let id = UUID()
    var name: String
    var duration: Int
    var isChecked: Bool
    var notificationEnabled: Bool = false
}

struct AthleticView: View {
    @State private var activities: [AthleticActivity] = [
//        AthleticActivity(name: "Running", duration: 30, isChecked: false),
//        AthleticActivity(name: "Weightlifting", duration: 45, isChecked: false),
//        AthleticActivity(name: "Yoga", duration: 60, isChecked: false)
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.indices) { index in
                    AthleticListCell(activity: $activities[index])
                }
                .onDelete(perform: deleteActivities)
            }
            .navigationBarTitle("Athletic View")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddAthleticActivityView(activities: $activities)) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    private func deleteActivities(at offsets: IndexSet) {
        activities.remove(atOffsets: offsets)
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
