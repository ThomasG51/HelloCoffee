//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import SwiftUI

struct OrderCellView: View {
    // MARK: - Property

    let order: Order

    // MARK: - View Body

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .accessibilityIdentifier("orderNameText")
                    .bold()
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                    .opacity(0.5)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}
