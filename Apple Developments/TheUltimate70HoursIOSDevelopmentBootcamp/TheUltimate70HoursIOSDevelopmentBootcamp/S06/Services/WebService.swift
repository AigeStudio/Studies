//
//  WebService.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 25/6/2024.
//

import Foundation

enum NetworkErrorS06: Error {
    case badURL
    case badRequest
    case decodingError
}

class WebService {
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkErrorS06.badURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkErrorS06.badRequest }
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else { throw NetworkErrorS06.decodingError }
        return products
    }
}
