//
//  longwood_class_selectorApp.swift
//  longwood class selector
//
//  Created by Cade Kukk on 4/5/25.
//

import SwiftUI

@main
struct longwood_class_selectorApp: App {
    // Create the view model at the app level to avoid redundant data loading
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
