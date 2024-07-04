//
//  WebService.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 1/7/2024.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

class WebService {
    private var baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func updateOrder(_ order:Order) async throws -> Order {
        guard let orderId = order.id else { throw NetworkError.badRequest }
        guard let url = URL(string: Endpoints.updateOrder(orderId).path, relativeTo: baseURL) else { throw NetworkError.badUrl }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.badRequest }
        guard let updateOrder = try? JSONDecoder().decode(Order.self, from: data) else { throw NetworkError.decodingError }
        return updateOrder
    }

    func deleteOrder(orderId: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: baseURL) else { throw NetworkError.badUrl }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.badRequest }
        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else { throw NetworkError.decodingError }
        return deletedOrder
    }

    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else { throw NetworkError.badUrl }
        var requset = URLRequest(url: url)
        requset.httpMethod = "POST"
        requset.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requset.httpBody = try JSONEncoder().encode(order)

        let (data, response) = try await URLSession.shared.data(for: requset)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.badRequest }

        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else { throw NetworkError.decodingError }

        return newOrder
    }

    func getOrders() async throws -> [Order] {
        // https://island-bramble.glitch.me/test/orders
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else { throw NetworkError.badUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.badRequest }
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else { throw NetworkError.decodingError }
        return orders
    }
}
