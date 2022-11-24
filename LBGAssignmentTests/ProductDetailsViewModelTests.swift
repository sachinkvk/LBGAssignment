//
//  ProductDetailsViewModelTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 23/11/22.
//

import XCTest
@testable import LBGAssignment

final class ProductDetailsViewModelTests: XCTestCase {
    var sut: ProductDetailsViewModel!

    override func setUpWithError() throws {
        sut = ProductDetailsViewModel(product: MockProduct.getProduct())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testScreenTitle() throws {
        XCTAssertEqual(sut.screenTitle, "Product Details")
    }

    func testFormattedPrice() {
        XCTAssertNotEqual(sut.product.formattedPrice, "$ 23")
        XCTAssertNotEqual(sut.product.formattedPrice, "23")
        XCTAssertEqual(sut.product.formattedPrice, "$23.0")
    }

    func testFormattedRating() {
        XCTAssertNotEqual(sut.product.formattedRating, "Rating 12/5")
        XCTAssertNotEqual(sut.product.formattedRating, "12.0/5")
        XCTAssertEqual(sut.product.formattedRating, "Rating 12.0/5")
    }
}
