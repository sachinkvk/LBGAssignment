//
//  MockProduct.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import Foundation
@testable import LBGAssignment

class MockProduct {
    static func getProducts() -> [Product] {
        return [Product(id: 1, title: "Title", price: 23, description: "description", category: "category",
                         image: "image", rating: Rating(rate: 12, count: 12))]
    }

    static func getProduct() -> Product {
        return Product(id: 1, title: "Title", price: 23, description: "description", category: "category",
                        image: "image", rating: Rating(rate: 12, count: 12))
    }
}
