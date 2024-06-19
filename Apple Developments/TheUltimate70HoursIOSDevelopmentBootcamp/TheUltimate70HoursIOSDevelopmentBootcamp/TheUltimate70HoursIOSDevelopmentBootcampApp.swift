//
//  TheUltimate70HoursIOSDevelopmentBootcampApp.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/18.
//

import SwiftUI

@main
struct TheUltimate70HoursIOSDevelopmentBootcampApp: App {
    
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            S04ContentView()
                .environmentObject(appState)
        }
    }
}
