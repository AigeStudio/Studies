//
//  ContentView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: CoffeeModel
    func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            if model.orders.isEmpty {
                Text("No orders available!").accessibilityIdentifier("noOrdersTezt")
            } else {
                List(model.orders) { order in
                    OrderCellView(order: order)
                }
            }
        }.task {
            await populateOrders()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        ContentView().environmentObject(CoffeeModel(webservice: WebService(baseURL: config.environment.baseURL)))
    }
}
