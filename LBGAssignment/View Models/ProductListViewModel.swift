//
//  ProductListViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

struct ProductViewModel {
    let imageName: String
    let title: String
    let desc: String
    let price: Double
    let rating: Double
}

final class ProductListViewModel {
    var products = [Products]()
    
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self)
            completion(result)
        }
    }
}
