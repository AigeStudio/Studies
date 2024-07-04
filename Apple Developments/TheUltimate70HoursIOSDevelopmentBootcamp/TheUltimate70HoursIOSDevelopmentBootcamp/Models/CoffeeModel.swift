//
//  CoffeeModel.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 1/7/2024.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    let webservice: WebService
    @Published private(set) var orders: [Order] = []

    init(webservice: WebService) {
        self.webservice = webservice
    }

    func orderById(_ id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else { return nil }
        return orders[index]
    }

    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }

    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order: order)
        orders.append(newOrder)
    }

    func deletedOrder(_ orderId: Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(orderId: orderId)
        orders = orders.filter { $0.id != deletedOrder.id }
    }

    func updateOrder(_ order: Order) async throws {
        let updatedOrder = try await webservice.updateOrder(order)
        guard let index = orders.firstIndex(where: { $0.id == updatedOrder.id }) else { throw CoffeeOrderError.invalidOrderId }
        orders[index] = updatedOrder
    }
}
