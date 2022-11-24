//
//  ServiceClient.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

protocol ApiResource {
    var path: String { get }
    var method: HttpMethod { get }
    var request: URLRequest { get }
}

enum RequestTypes {
    case allProducts
}

extension RequestTypes: ApiResource {
    private var baseUrl: String {
        return ServiceUrl.baseURL
    }

    var method: HttpMethod {
        switch self {
        case .allProducts:
            return .get
        }
    }

    var path: String {
        switch self {
        case .allProducts:
            return baseUrl + "/products"
        }
    }

    var request: URLRequest {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
