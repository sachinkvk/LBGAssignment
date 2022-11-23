//
//  DataMocker.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import XCTest

class DataMocker {
    static func getServerUrl() -> URL? {
        return URL(string: "https://fakestoreapi.com")
    }
    
    static func serialiseJsonData(mockedData: [String: Any]) -> Data {
        var jsonData = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: mockedData, options: .prettyPrinted)
        } catch {
        }
        return jsonData
    }
    
    static func setMockedData(mockData: [String: Any], requestUrl: URL?, statusCode: Int) {
        let serialisedData = serialiseJsonData(mockedData: mockData)
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == requestUrl else {
                return (HTTPURLResponse(), Data())
            }
            if let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil) {
                return (response, serialisedData)
            }
            return (HTTPURLResponse(), Data())
        }
    }
    
    static func getSessionConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.protocolClasses = [MockURLProtocol.self]
        return sessionConfiguration
    }
    
}
