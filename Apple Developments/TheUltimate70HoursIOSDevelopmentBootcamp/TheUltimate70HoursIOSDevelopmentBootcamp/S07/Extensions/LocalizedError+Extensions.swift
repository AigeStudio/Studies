//
//  LocalizedError+Extensions.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 30/6/2024.
//

import Foundation

extension LocalizedError {
    var id: Int {
        localizedDescription.hashValue
    }
}
