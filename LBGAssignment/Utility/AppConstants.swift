//
//  AppConstants.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum ServiceUrl {
    static let baseURL = "https://fakestoreapi.com"
}

struct AppConstant {
    struct CellIdentifiers {
        static let productCellIdentifier = "productCellIdentifier"
        static let productCollectionViewCell = "ProductCollectionViewCell"
    }
    
    static func readJSONFrom(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return json
    }
}
