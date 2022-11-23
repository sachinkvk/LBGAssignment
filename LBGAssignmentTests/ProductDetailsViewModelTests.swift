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
        sut = ProductDetailsViewModel(product: ProductViewModel(imageName: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                                                                title: "Mens Casual Premium Slim Fit T-Shirts ",
                                                                desc: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                                                                price: 134,
                                                                rating: 4.1,
                                                                category: "men's clothing"))
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        XCTAssertEqual(sut.product.formattedRating, "4.1/5")
    }
    
}
