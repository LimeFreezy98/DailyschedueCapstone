//
//  AddAthleticActivityView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 5/31/23.
//

import SwiftUI

struct AddAthleticActivityView: View {
    @Binding var activities: [AthleticActivity]
    @Environment(\.presentationMode) var presentationMode
    @State private var activityName: String = ""
    @State private var activityDuration: String = ""
    
    var body: some View {
        VStack {
            TextField("Activity Name", text: $activityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Duration (min)", text: $activityDuration)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            Button(action: addActivity) {
                Text("Add Activity")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Add Activity")
    }
    
    private func addActivity() {
        guard let duration = Int(activityDuration) else {
            // Handle invalid duration input
            return
        }
        
        let newActivity = AthleticActivity(name: activityName, duration: duration, isChecked: false)
        activities.append(newActivity)
        
        // Dismiss the AddAthleticActivityView and return to the AthleticView
        presentationMode.wrappedValue.dismiss()
    }
}
//struct AddAthleticActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAthleticActivityView()
//    }
//}

