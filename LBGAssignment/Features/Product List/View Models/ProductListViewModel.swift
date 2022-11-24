//
//  ProductListViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum SortingTypes: String {
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

protocol ProductListProtocol {
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void)
    func translateProducts(_ products: [Products])
}

final class ProductListViewModel: SortProductProtocol {
    
    var products = [ProductViewModel]()
    var productsCopy = [ProductViewModel]()
    var isSortingApplied = false
    var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.init(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    var productList: [ProductViewModel] {
        return isSortingApplied ? productsCopy : products
    }
    
    func sortBy(order: SortingTypes) -> [ProductViewModel] {
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

extension ProductListViewModel: ProductListProtocol {
    func fetchProducts(_ completion: @escaping (Result<[Products], ServiceError>) -> Void) {
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self,
                                                                session: urlSession)
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
}

extension ProductListViewModel {
    var screenTitle: String {
        return "Products"
    }
    
    var pullToRefreshText: String {
        return "Pull to refresh"
    }
    
}
