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
        return [Product(id: 1, title: "Mens Cotton Jacket", price: 23,
                        description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket,",
                        category: "men's clothing",
                         image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
                        rating: Rating(rate: 12, count: 12))]
    }

    static func getProduct() -> Product {
        return Product(id: 4, title: "Mens Casual Premium Slim Fit T-Shirts ", price: 23,
                       description: "Slim-fitting style, contrast raglan long sleeve, three-button henley placket,",
                       category: "men's clothing",
                        image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
                       rating: Rating(rate: 12, count: 12))
    }
}
