//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Thomas George on 29/11/2022.
//

import SwiftUI

struct OrderDetailView: View {
    // MARK: - Property

    let id: Int

    // MARK: - Binding

    @EnvironmentObject private var model: CoffeeModel

    @Environment(\.dismiss) private var dismiss

    @State private var isShowingSheet = false

    // MARK: - View Body

    var body: some View {
        if let order = model.getOrderById(id) {
            VStack {
                VStack(alignment: .leading) {
                    Text(order.coffeeName)
                        .font(.title)
                        .padding(.bottom, 10)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.size.rawValue)
                        .opacity(0.5)
                        .accessibilityIdentifier("sizeText")
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                        .accessibilityIdentifier("totalText")
                }
                .padding(.bottom, 20)

                HStack {
                    Button("Delete order", role: .destructive) {
                        removeOrder()
                    }
                    .accessibilityIdentifier("deleteOrderButton")
                    Button("Edit order") {
                        isShowingSheet = true
                    }
                    .accessibilityIdentifier("editOrderButton")
                }
                Spacer()
            }
            .sheet(isPresented: $isShowingSheet) {
                HandleOrderView(order: order)
            }
        }
    }

    // MARK: - View Function

    private func removeOrder() {
        Task {
            do {
                try await model.deleteOrder(by: id)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Preview

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(id: 1)
            .environmentObject(CoffeeModel())
    }
}
