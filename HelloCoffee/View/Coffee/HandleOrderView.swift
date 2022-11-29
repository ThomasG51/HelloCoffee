//
//  HandleOrderView.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import SwiftUI

struct HandleOrderView: View {
    // MARK: - Property

    var order: Order?

    private var isFormValid: Bool {
        return
            !name.isEmpty &&
            !coffeeName.isEmpty &&
            !price.isEmpty &&
            price.isNumeric &&
            !price.isLessThan(1)
    }

    // MARK: - Binding

    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var coffeeName = ""
    @State private var price = ""
    @State private var coffeeSize: CoffeeSize = .medium

    // MARK: - View Body

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .accessibilityIdentifier("nameText")
                    TextField("Coffee name", text: $coffeeName)
                        .accessibilityIdentifier("coffeeNameText")
                    TextField("Price", text: $price)
                        .accessibilityIdentifier("priceText")
                        .keyboardType(.decimalPad)
                    Picker("Select size", selection: $coffeeSize) {
                        ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                            Text(size.rawValue)
                                .tag(size)
                        }
                    }
                    .pickerStyle(.segmented)
                    Button(order == nil ? "Place Order" : "Update Order") {
                        Task {
                            await placeOrUpdateOrder()
                        }
                    }
                    .accessibilityIdentifier("placeOrderButton")
                    .centerHorizontal()
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle(order == nil ? "Add Coffee" : "Update Coffee")
            .onAppear {
                populateExistingOrder()
            }
        }
    }

    // MARK: - View Function

    private func placeOrUpdateOrder() async {
        if var updatedOrder = self.order {
            updatedOrder.name = name
            updatedOrder.coffeeName = coffeeName
            updatedOrder.total = Double(price) ?? 0
            updatedOrder.size = coffeeSize
            do {
                try await model.updateOrder(updatedOrder)
                dismiss()
            } catch {
                print(error)
            }
        } else {
            let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
            do {
                try await model.placeOrder(order)
                dismiss()
            } catch {
                print(error)
            }
        }
    }

    private func populateExistingOrder() {
        if let order = self.order {
            name = order.name
            coffeeName = order.coffeeName
            price = String(order.total)
            coffeeSize = order.size
        }
    }
}

// MARK: - Preview

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        HandleOrderView()
            .environmentObject(CoffeeModel())
    }
}
