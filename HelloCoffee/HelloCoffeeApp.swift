//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import SwiftUI

@main
struct HelloCoffeeApp: App {
    @StateObject private var model = CoffeeModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
