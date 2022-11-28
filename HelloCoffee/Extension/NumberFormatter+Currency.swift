//
//  NumberFormatter+Currency.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
