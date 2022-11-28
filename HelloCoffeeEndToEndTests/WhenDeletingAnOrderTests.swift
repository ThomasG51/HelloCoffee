//
//  WhenDeletingAnOrderTests.swift
//  HelloCoffeeEndToEndTests
//
//  Created by Thomas George on 28/11/2022.
//

import XCTest

final class WhenDeletingAnOrderTests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField = app.textFields["nameText"]
        nameTextField.tap()
        nameTextField.typeText("Lisa")
        
        let coffeeNameTextField = app.textFields["coffeeNameText"]
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Capuccino")
        
        let priceTextField = app.textFields["priceText"]
        priceTextField.tap()
        priceTextField.typeText("1.49")
        
        let placeOrderButton = app.buttons["placeOrderButton"]
        placeOrderButton.tap()
    }
    
    func test_should_delete_order_successfully() {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        let orderlist = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderlist.cells.count)
    }
    
    override func tearDown() async throws {
        guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
        let _ = try await URLSession.shared.data(from: url)
    }
}
