//
//  String+isLessThan.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

extension String {
    func isLessThan(_ number: Double) -> Bool {
        // isNumeric extension required
        if !self.isNumeric {
            return false
        }
        guard let value = Double(self) else { return false }
        return value < number
    }
}
