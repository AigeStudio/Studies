//
//  StoreModel.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 27/6/2024.
//

import Foundation

@MainActor
class StoreModel: ObservableObject {
    @Published var products: [Product] = []
    let webservice: WebService
    init(webservice: WebService) {
        self.webservice = webservice
    }

    func populateProducts() async throws {
        products = try await webservice.getProducts()
    }
}
