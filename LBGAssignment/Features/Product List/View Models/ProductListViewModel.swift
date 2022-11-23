//
//  ProductListViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum SortingList: String {
    case lowToHigh = "High To Low"
    case HighToLow = "Low to High"
    case Cancel = "Cancel"
}

protocol SortProductProtocol {
    associatedtype T
    associatedtype Items
    func sortBy(order: T) -> [Items]
    var isSortingApplied: Bool { get }
}

final class ProductListViewModel: SortProductProtocol {
    
    var products = [ProductViewModel]()
    var productsCopy = [ProductViewModel]()
    var isSortingApplied = false
    
    var productList: [ProductViewModel] {
        return isSortingApplied ? productsCopy : products
    }
    
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self)
            completion(result)
        }
    }
    
    func translateProducts(_ products: [Products]) {
        for eachProduct in products {
            self.products.append(ProductViewModel(imageName: eachProduct.image ?? "",
                                         title: eachProduct.title ?? "",
                                         desc: eachProduct.description ?? "",
                                         price: eachProduct.price ?? 0,
                                         rating: eachProduct.rating?.rate ?? 0,
                                         category: eachProduct.category ?? ""))
        }
    }
    
    func sortBy(order: SortingList) -> [ProductViewModel] {
        switch order {
        case .HighToLow:
            return productsCopy.sorted(by: { $0.price < $1.price })
        case .lowToHigh:
            return productsCopy.sorted(by: { $0.price > $1.price })
        default:
            return []
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
