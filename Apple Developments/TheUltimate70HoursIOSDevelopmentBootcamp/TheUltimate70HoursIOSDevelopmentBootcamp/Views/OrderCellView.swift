//
//  OrderCellView.swift
//  TheUltimate70HoursIOSDevelopmentBootcamp
//
//  Created by AigeStudio on 2/7/2024.
//

import SwiftUI

struct OrderCellView: View {
    let order: Order

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name).accessibilityIdentifier("orderNameText")
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue)")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                    .opacity(0.5)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}
