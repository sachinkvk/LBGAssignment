//
//  ApiClient.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

protocol APIClient {
    func fetch<T: Codable>(with request: URLRequest, decodingType: T.Type,
                           session: URLSession) async -> Result<T, ServiceError>
}

extension APIClient {
    func fetch<T: Codable>(with request: URLRequest, decodingType: T.Type,
                           session: URLSession = URLSession(configuration: .default)) async -> Result<T, ServiceError> {
        do {
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
            case 400:
                return .failure(.badStatusCode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
