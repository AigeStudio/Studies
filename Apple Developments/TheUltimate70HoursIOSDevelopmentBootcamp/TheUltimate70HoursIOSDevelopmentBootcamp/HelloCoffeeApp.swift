//
//  TheUltimate70HoursIOSDevelopmentBootcampApp.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/18.
//

import SwiftUI

@main
struct HelloCoffeeApp: App {
    @StateObject private var model: CoffeeModel
    init() {
        var config = Configuration()
        let webservice = WebService(baseURL: config.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
