//
//  ApiClient.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

protocol APIClient {
    func fetch<T: Codable>(with request: URLRequest, decodingType: T.Type) async -> Result<T, ServiceError>
}

extension APIClient {
    func fetch<T: Codable>(with request: URLRequest, decodingType: T.Type) async -> Result<T, ServiceError> {
        do {
            let session = URLSession(configuration: URLSessionConfiguration.default)

            let (data, response) = try await session.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200:
                guard let decodedResponse = try? JSONDecoder().decode(decodingType.self, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch(let err) {
            print(err.localizedDescription)
            return .failure(.unknown)
        }
    }
}
