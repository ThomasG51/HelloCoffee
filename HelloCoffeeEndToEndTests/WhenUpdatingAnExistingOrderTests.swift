//
//  WhenUpdatingAnExistingOrderTests.swift
//  HelloCoffeeEndToEndTests
//
//  Created by Thomas George on 29/11/2022.
//

import XCTest

final class WhenUpdatingAnExistingOrderTests: XCTestCase {
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
        coffeeNameTextField.typeText("Cappuccino")
        
        let priceTextField = app.textFields["priceText"]
        priceTextField.tap()
        priceTextField.typeText("1.49")
        
        let placeOrderButton = app.buttons["placeOrderButton"]
        placeOrderButton.tap()
    }
    
    func test_should_update_order_successfully() {
        let collectionViewsQuery = app.collectionViews["orderList"]
        collectionViewsQuery.buttons["orderNavigationLink"].tap()
        app.buttons["editOrderButton"].tap()
        app.textFields["coffeeNameText"].tap()
        app.textFields["coffeeNameText"].typeText(" Edited")
        app.buttons["Large"].tap()
        app.buttons["placeOrderButton"].tap()
        XCTAssertEqual("Cappuccino Edited", app.staticTexts["coffeeNameText"].label)
        XCTAssertEqual("Large", app.staticTexts["sizeText"].label)
    }
    
    override func tearDown() async throws {
        guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
        let _ = try await URLSession.shared.data(from: url)
    }
}
