//
//  CoffeeModel.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject { // Can be called CoffeeManager
    // MARK: - Property
    
    let webservice = Webservice()
    
    @Published private(set) var orders: [Order] = []
    
    // MARK: - Function
    
    /// Populate orders that should be displayed to the view
    ///
    func populateOrders() async throws {
        orders = try await webservice.getOrders()
    }
    
    /// Place and add new order the view
    ///
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order)
        orders.append(newOrder)
    }
}
