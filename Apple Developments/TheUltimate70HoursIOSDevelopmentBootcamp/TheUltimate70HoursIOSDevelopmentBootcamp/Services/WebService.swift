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
