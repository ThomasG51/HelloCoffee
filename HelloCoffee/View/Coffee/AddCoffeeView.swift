//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by Thomas George on 28/11/2022.
//

import SwiftUI

struct AddCoffeeView: View {
    // MARK: - Property

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
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontal()
                .disabled(!isFormValid)
            }
            Section {}
        }
    }

    // MARK: - View Function

    private func placeOrder() async {
        let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
        do {
            try await model.placeOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
}

// MARK: - Preview

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
            .environmentObject(CoffeeModel())
    }
}
