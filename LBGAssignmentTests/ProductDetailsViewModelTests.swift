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
        XCTAssertNotEqual(sut.product.formattedPrice, "$ 134")
        XCTAssertNotEqual(sut.product.formattedPrice, "134")
        XCTAssertEqual(sut.product.formattedPrice, "$ 134.0")
    }
    
    func testFormattedRating() {
        XCTAssertEqual(sut.product.formattedRating, "Rating 4.1/5")
    }
    
}
