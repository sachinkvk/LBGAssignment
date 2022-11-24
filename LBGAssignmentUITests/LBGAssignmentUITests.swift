//
//  LBGAssignmentUITests.swift
//  LBGAssignmentUITests
//
//  Created by Sachin Panigrahi on 20/11/22.
//

import XCTest

final class LBGAssignmentUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductSelection() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 1).staticTexts["ProductNameLabel"].tap()
        let productCategory = app.scrollViews.otherElements.staticTexts["ProductCategoryLabel"]
        XCTAssertTrue(productCategory.exists, "product detail screen visible")
        XCTAssert(app.navigationBars["Product Details"].exists)
    }

    func testProductListScreenTitle() {
        let app = XCUIApplication()
        XCTAssert(app.navigationBars["Products"].exists)
    }

    func testSortButtonVisibiltiy() {
        let app = XCUIApplication()
        XCTAssert(app.staticTexts["Sort"].exists)
    }

    func testActionSheetVisibility() {
        let app = XCUIApplication()
        app.staticTexts["Sort"].tap()
        XCTAssert(app.staticTexts["Price"].exists)
    }
}
