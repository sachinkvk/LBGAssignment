//
//  ProductCollectionViewCellTests.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import XCTest
@testable import LBGAssignment

class ProductCollectionViewCellTests: XCTestCase {

    var subject: ProductCollectionViewCell!
    var productRating: UILabel!
    var productPrice: UILabel!
    var productName: UILabel!
    var productImageView: UIImageView!
    var containerView: UIView!
    var products: [Product] = []
    var product: Product!

    override func setUp() {
       super.setUp()
        subject = ProductCollectionViewCell()
        productRating = UILabel()
        productPrice = UILabel()
        productName = UILabel()
        productImageView = UIImageView()
        containerView = UIView()

        subject.setValue(productRating, forKey: "productRating")
        subject.setValue(productPrice, forKey: "productPrice")
        subject.setValue(productName, forKey: "productName")
        subject.setValue(productImageView, forKey: "productImageView")
        subject.setValue(containerView, forKey: "containerView")
        product = MockProduct.getProduct()
        subject.productViewModel = product
    }

    override func tearDown() {
        productRating = nil
        productName = nil
        productPrice = nil
        productImageView = nil
        subject = nil
        super.tearDown()
    }

    func test_awakeFromNib_setExpectedValues() {
        subject.awakeFromNib()
        XCTAssertNotNil(productRating.text)
        XCTAssertNotNil(productPrice.text)
        XCTAssertNotNil(productName.text)
    }
}
