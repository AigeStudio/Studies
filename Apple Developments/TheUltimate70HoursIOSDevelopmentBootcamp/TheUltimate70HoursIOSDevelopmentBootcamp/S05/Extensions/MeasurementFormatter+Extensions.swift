//
//  MeasurementFormatter.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by Aige on 2024/06/20.
//

import Foundation

extension MeasurementFormatter {
    static func temperature(value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "CN")
        formatter.numberFormatter = numberFormatter
        
        let temp = Measurement(value: value, unit: UnitTemperature.kelvin)
        
        return formatter.string(from: temp)
    }
}
