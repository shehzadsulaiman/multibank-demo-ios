//
//  multibankUITests.swift
//  multibankUITests
//
//  Created by shehzad on 26/02/2026.
//

import XCTest

final class multibankUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testFeedScreenLoadsAndShowsCoreControls() throws {
        let app = XCUIApplication()
        app.launch()

        let list = app.descendants(matching: .any).matching(identifier: "marketFeedList").firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5))

        let statusLabel = app.staticTexts["connectionStatusLabel"]
        XCTAssertTrue(statusLabel.waitForExistence(timeout: 5))

        let toggleButton = app.buttons["feedToggleButton"]
        XCTAssertTrue(toggleButton.waitForExistence(timeout: 5))
        XCTAssertTrue(toggleButton.label == "stop" || toggleButton.label == "start")
    }

    @MainActor
    func testFeedToggleButtonSwitchesStartStopState() throws {
        let app = XCUIApplication()
        app.launch()

        let toggleButton = app.buttons["feedToggleButton"]
        XCTAssertTrue(toggleButton.waitForExistence(timeout: 5))

        let initialLabel = toggleButton.label
        toggleButton.tap()

        let expectedLabel = (initialLabel == "stop") ? "start" : "stop"
        let predicate = NSPredicate(format: "label == %@", expectedLabel)
        expectation(for: predicate, evaluatedWith: toggleButton)
        waitForExpectations(timeout: 5)
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
