//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badRequest
    case decodingError
}

enum Endpoints {
    case allOrders
    case placeOrder
    case deleteOrder(Int)
}

extension Endpoints {
    var path: String {
        switch self {
        case .allOrders:
            return "test/orders"
        case .placeOrder:
            return "test/new-order"
        case .deleteOrder(let id):
            return "test/orders/\(id)"
        }
    }
}

class Webservice {
    // MARK: - Property

    private var baseURL: URL

    // MARK: - init

    init() {
        var config = Configuration()
        self.baseURL = config.environment.baseURL
    }

    // MARK: - Function

    /// Get all orders from server
    ///
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }

        return orders
    }

    /// Place a new coffee order
    ///
    /// - parameters order: The `Order` object that should be post to the server
    ///
    func placeOrder(_ order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(order)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        guard let order = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }

        return order
    }

    /// Delete a coffee order
    ///
    /// - parameters id: The id of order that should be deleted from the server
    ///
    func deleteOrder(id: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.deleteOrder(id).path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }

        guard let order = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }

        return order
    }
}
