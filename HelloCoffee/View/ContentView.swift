//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property

    // MARK: - Binding

    @EnvironmentObject private var model: CoffeeModel

    @State private var isSheetPresented = false

    // MARK: - View Body

    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!")
                        .accessibilityIdentifier("noOrderText")
                } else {
                    List {
                        ForEach(model.orders) { order in
                            OrderCellView(order: order)
                        }
                        .onDelete(perform: removeOrder)
                    }
                }
            }
            .task {
                await getOrders()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add new order") {
                        isSheetPresented = true
                    }
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
            .sheet(isPresented: $isSheetPresented) {
                AddCoffeeView()
            }
        }
    }

    // MARK: - View Function

    private func getOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }

    private func removeOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let id = order.id else { return }
            Task {
                do {
                    try await model.deleteOrder(by: id)
                } catch {
                    print(error)
                }
            }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoffeeModel())
    }
}
