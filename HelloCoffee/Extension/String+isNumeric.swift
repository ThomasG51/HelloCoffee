//
//  String+isNumeric.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
}
