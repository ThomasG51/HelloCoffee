//
//  WhenAppIsLaunchedWithNoOrdersTests.swift
//  HelloCoffeeEndToEndTests
//
//  Created by Thomas George on 28/11/2022.
//

import XCTest

final class WhenAppIsLaunchedWithNoOrdersTests: XCTestCase {
    func test_should_make_sure_no_orders_message_is_displayed() {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        XCTAssertEqual("No orders available!", app.staticTexts["noOrderText"].label)
    }
}
