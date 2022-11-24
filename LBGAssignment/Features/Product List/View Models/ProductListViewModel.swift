//
//  ProductListViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum SortOptions: String {
    case lowToHigh = "High To Low"
    case highToLow = "Low to High"
}

protocol SortProductProtocol {
    associatedtype Order
    associatedtype Items
    func sortBy(order: Order) -> [Items]
    var isSortingApplied: Bool { get }
}

protocol ProductListProtocol {
    func fetchProducts(_ completion: @escaping (Result<[Product], ServiceError>) -> Void)
}

final class ProductListViewModel: SortProductProtocol {

    var products = [Product]()
    var productsCopy = [Product]()
    var isSortingApplied = false

    var productList: [Product] {
        return isSortingApplied ? productsCopy : products
    }

    func sortBy(order: SortOptions) -> [Product] {
        switch order {
        case .highToLow:
            return productsCopy.sorted(by: { $0.price < $1.price })
        case .lowToHigh:
            return productsCopy.sorted(by: { $0.price > $1.price })
        }
    }
}

extension ProductListViewModel: ProductListProtocol {
    func fetchProducts(_ completion: @escaping (Result<[Product], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Product].self)
            completion(result)
        }
    }
}

extension ProductListViewModel {
    var screenTitle: String {
        return "Products"
    }
}
