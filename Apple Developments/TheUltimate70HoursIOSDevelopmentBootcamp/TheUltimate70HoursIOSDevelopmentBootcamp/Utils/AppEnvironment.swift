//
//  AppEnvironment.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 2/7/2024.
//

import Foundation

enum Endpoints {
    case allOrders
    case placeOrder
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        guard let env = ProcessInfo.processInfo.environment["ENV"] else { return AppEnvironment.dev }
        if env == "TEST" {
            return AppEnvironment.test
        }
        return AppEnvironment.dev
    }()
}

enum AppEnvironment: String {
    case dev
    case test

    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}
