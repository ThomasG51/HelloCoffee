//
//  CoffeeModel.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

enum CoffeeModelError: Error {
    case orderNotFound
}

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
    
    /// Place and add new order to the view
    ///
    /// - parameters order: The `Order` object that should be added to the view
    ///
    func placeOrder(_ order: Order) async throws {
        let newOrder = try await webservice.placeOrder(order)
        orders.append(newOrder)
    }
    
    /// Delete and remove an order from the view
    ///
    /// - parameters id: The ID of the order that should be removed from the view
    ///
    func deleteOrder(by id: Int) async throws {
        let deletedOrder = try await webservice.deleteOrder(id: id)
        orders = orders.filter { $0.id != deletedOrder.id }
    }
    
    /// Update an order from the orders list view
    ///
    /// - parameters order: The `Order` object that should be updated
    ///
    func updateOrder(_ order: Order) async throws {
        let updatedOrder = try await webservice.updateOrder(order)
        guard let index = orders.firstIndex(where: { $0.id == updatedOrder.id }) else {
            throw CoffeeModelError.orderNotFound
        }
        orders[index] = updatedOrder
    }
    
    /// Get one order from orders list view
    ///
    /// - parameters id: The ID of the required order
    ///
    func getOrderById(_ id: Int) -> Order? {
        guard let index = orders.firstIndex(where: { $0.id == id }) else { return nil }
        return orders[index]
    }
}
