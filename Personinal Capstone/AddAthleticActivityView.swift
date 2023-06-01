//
//  AddAthleticActivityView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/31/23.
//

import SwiftUI

struct AddAthleticActivityView: View {
    @Binding var activities: [AthleticActivity]
    @State private var activityName = ""
    @State private var duration = 0
    @State private var notificationEnabled = false
    @Environment(\.presentationMode) var presentationMode
    
    let addActivity: (AthleticActivity) -> Void
    
    var body: some View {
        VStack {
            TextField("Activity Name", text: $activityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Stepper(value: $duration, in: 0...120, step: 5) {
                Text("Duration: \(duration) mins")
            }
            .padding()
            
            Toggle(isOn: $notificationEnabled) {
                Text("Enable Notification")
            }
            .padding()
            
            Button(action: {
                let newActivity = AthleticActivity(id: UUID().uuidString, name: activityName, duration: duration, isChecked: false, notificationEnabled: notificationEnabled)
                addActivity(newActivity)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add Activity")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

//struct AddAthleticActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAthleticActivityView()
//    }
//}

