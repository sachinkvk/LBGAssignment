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
    associatedtype SortType
    associatedtype Items
    func sortBy(order: SortType) -> [Items]
    var isSortingApplied: Bool { get }
}

protocol ProductListProtocol {
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void)
}

final class ProductListViewModel: SortProductProtocol {

    var products = [Products]()
    var productsCopy = [Products]()
    var isSortingApplied = false
    var urlSession: URLSession

    init(urlSession: URLSession = URLSession.init(configuration: .default)) {
        self.urlSession = urlSession
    }

    var productList: [Products] {
        return isSortingApplied ? productsCopy : products
    }

    func sortBy(order: SortOptions) -> [Products] {
        switch order {
        case .highToLow:
            return productsCopy.sorted(by: { $0.price < $1.price })
        case .lowToHigh:
            return productsCopy.sorted(by: { $0.price > $1.price })
        }
    }
}

extension ProductListViewModel: ProductListProtocol {
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self,
                                                               session: urlSession)
            completion(result)
        }
    }
}

extension ProductListViewModel {
    var screenTitle: String {
        return "Products"
    }
}
