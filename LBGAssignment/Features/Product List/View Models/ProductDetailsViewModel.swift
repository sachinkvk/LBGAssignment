//
//  ProductDetailsViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

class ProductDetailsViewModel {
    let product: ProductViewModel
    
    init(product: ProductViewModel) {
        self.product = product
    }
}

extension ProductDetailsViewModel {
    var screenTitle: String {
        "Product Details"
    }
}
