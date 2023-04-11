//
//  Personinal_CapstoneApp.swift
//  Personinal Capstone
//
//  Created by Vasiliy on 3/2/23.
//

import SwiftUI

@MainActor
class AppViewModel: ObservableObject {
    @Published var events: [Event] {
        didSet {
            Events.saveEvents(events)
        }
    }
    
    init() {
        self.events = Events.loadEvents()
    }
}

@main
struct Personinal_CapstoneApp: App {
    @StateObject var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(eventStorage: $viewModel.events)
        }
    }
}
