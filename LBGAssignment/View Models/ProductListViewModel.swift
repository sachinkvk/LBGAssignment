//
//  ProductListViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

final class ProductListViewModel {
    
    var products = [ProductViewModel]()
    
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self)
            completion(result)
        }
    }
    
    func mapProducts(_ products: [Products]) {
        for eachProduct in products {
            self.products.append(ProductViewModel(imageName: eachProduct.image ?? "",
                                         title: eachProduct.title ?? "",
                                         desc: eachProduct.description ?? "",
                                         price: eachProduct.price ?? 0,
                                         rating: eachProduct.rating?.rate ?? 0,
                                         category: eachProduct.category ?? ""))
        }
    }
}

extension ProductListViewModel {
    var screenTitle: String {
        return "Products"
    }
    
    var pullToRefreshText: String {
        return "Pull to refresh"
    }
    
}
