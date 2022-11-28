//
//  View+CenterHorizontal.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontal() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
