//
//  MockProduct.swift
//  LBGAssignmentTests
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import Foundation
@testable import LBGAssignment

class MockProduct {
    static func getProducts() -> [Products] {
        return [Products(id: 1, title: "Title", price: 23, description: "description", category: "category",
                         image: "image", rating: Rating(rate: 12, count: 12))]
    }
    
    static func getProduct() -> ProductViewModel {
        return ProductViewModel(imageName: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
                                title: "Mens Casual Premium Slim Fit T-Shirts ",
                                desc: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                                price: 134,
                                rating: 4.1,
                                category: "men's clothing")
    }
}
