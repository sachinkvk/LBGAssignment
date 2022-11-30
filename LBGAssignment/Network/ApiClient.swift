//
//  ApiClient.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum HTTPStatusCode: Int {
    case success = 200
    case badStatusCode = 400
    case unAuthorized = 401
}

protocol APIClient {
    func fetch<T: Codable>(with request: URLRequest?, decodingType: T.Type) async -> Result<T, ServiceError>
}

extension APIClient {
    func fetch<T: Codable>(with request: URLRequest?, decodingType: T.Type) async -> Result<T, ServiceError> {
        do {
            let session = WebService.urlSession
            guard let request = request else {
                return .failure(.unknown)
            }
            let (data, response) = try await session.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case HTTPStatusCode.success.rawValue:
                guard let decodedResponse = try? JSONDecoder().decode(decodingType.self, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case HTTPStatusCode.badStatusCode.rawValue:
                return .failure(.badStatusCode)
            case HTTPStatusCode.unAuthorized.rawValue:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
