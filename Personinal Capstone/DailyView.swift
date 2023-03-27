//
//  DailyView.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/15/23.
//

import SwiftUI

struct DailyView: View {
    
//    var event Event
    // declare Event
    @State var localEvent: Event
    
    @State private var startTime = Date()
    @State private var endTime = Date()
//    @Binding var
//    var event: Event
    
    
    var body: some View {
        NavigationView {
            if let logs = localEvent.logs {
                var localLogs = logs
                List {
                    ForEach(localLogs) { index in
                        DailyCell()
                    }
                    .onDelete(perform: { indexSet in
    //                     Handle deletion logic here:
                        
                        
                        localLogs.remove(atOffsets: indexSet)
                    })
                    .overlay(
                        Group {
                            if localLogs.isEmpty {
                                Text("No data")
                            } else {
                                EmptyView()
                            }
                        }
                    )
                }
            }
//            List {
//                ForEach(localEvent.logs ?? [Log(title: "placeholder", startTime: Date(), endTime: Date())]) { index in
//                    DailyCell()
//                }
//                .onDelete(perform: { indexSet in
////                     Handle deletion logic here:
//
//
//                    localEvent.logs.remove(atOffsets: indexSet)
//                })
//                .overlay(
//                    Group {
//                        if localEvent.logs.isEmpty {
//                            Text("No data")
//                        } else {
//                            EmptyView()
//                        }
//                    }
//                )
//            }
        }
        
        .navigationBarTitle(Text("Daily"))
        .navigationBarItems(
            trailing:
                NavigationLink(destination: SecondAddEditView(logs: $localEvent)) {
                    Image(systemName: "plus")
                }
        )
    }
}


struct DailyCell: View {
    @State private var notificationEnabled = false
//    var log: Log
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title")
                    .font(.headline)
                Spacer()
                Toggle(isOn: $notificationEnabled) {
                    Text("Notifications")
                }
            }
            HStack {
                Text("Start:")
                    .font(.subheadline)
                Text("9:00 AM")
                    .foregroundColor(.gray)
            }
            HStack {
                Text("End:")
                    .font(.subheadline)
                Text("10:00 AM")
                    .foregroundColor(.gray)
            }
        }
    }
}
