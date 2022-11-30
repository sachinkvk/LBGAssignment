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
    func sortBy(_ order: Order) -> [Items]
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

    /* sort products based on sort order option selectecd by user */
    func sortBy(_ order: SortOptions) -> [Product] {
        switch order {
        case .highToLow:
            return productsCopy.sorted(by: { $0.price < $1.price })
        case .lowToHigh:
            return productsCopy.sorted(by: { $0.price > $1.price })
        }
    }
}

extension ProductListViewModel: ProductListProtocol {

    /* fetch products from api */
    func fetchProducts(_ completion: @escaping (Result<[Product], ServiceError>) -> Void) {
        Task {
            let result = await WebService().fetch(with: RequestTypes.allProducts.getRequest(),
                                                               decodingType: [Product].self)
            completion(result)
        }
    }
}

extension ProductListViewModel {
    var screenTitle: String {
        return "Products"
    }

    var cancelText: String {
        return "Cancel"
    }

    var priceText: String {
        return "Price"
    }
}
