//
//  ServiceError.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum ServiceError: Error {
    case unauthorized
    case decode
    case noResponse
    case unexpectedStatusCode
    case unknown
    var message: String {
        switch self {
        default:
            return "Something went wrong!"
        }
    }
}
