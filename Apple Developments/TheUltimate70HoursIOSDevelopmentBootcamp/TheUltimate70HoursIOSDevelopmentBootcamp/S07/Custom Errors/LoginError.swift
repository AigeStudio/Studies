//
//  LoginError.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 28/6/2024.
//

import Foundation

enum LoginError: Error, LocalizedError {
    case emailEmpty
    case emailInvalid
    case passwordEmpty

    var errorDescription: String? {
        switch self {
        case .emailEmpty:
            return "Email cannot be empty"
        case .emailInvalid:
            return "Email is not in correct format"
        case .passwordEmpty:
            return "Password cannot be empty"
        }
    }
}
