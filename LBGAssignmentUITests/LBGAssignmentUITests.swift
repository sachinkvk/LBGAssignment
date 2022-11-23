//
//  LBGAssignmentUITests.swift
//  LBGAssignmentUITests
//
//  Created by Sachin Panigrahi on 20/11/22.
//

import XCTest

final class LBGAssignmentUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPullToRefersh() {
        let app = XCUIApplication()
        app.activate()
        let firstCell = app.collectionViews.children(matching: .cell).element(boundBy: 0).staticTexts["ProductNameLabel"]
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        // 16 is to long drag down to happen pull to refresh
        start.press(forDuration: 0.3, thenDragTo: finish)
    }
    
    func testProductSelection() {
        let app = XCUIApplication()
        app.activate()
        app.collectionViews.children(matching: .cell).element(boundBy: 1).staticTexts["ProductNameLabel"].tap()
        let productCategory = app.scrollViews.otherElements.staticTexts["ProductCategoryLabel"]
        XCTAssertTrue(productCategory.exists, "product detail screen visible")
    }
    
    func testProductListScreenTitle() {
        let app = XCUIApplication()
        app.activate()
        XCTAssert(app.navigationBars["Products"].exists)
    }
}
