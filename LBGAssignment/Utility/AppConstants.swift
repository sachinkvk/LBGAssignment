//
//  AppConstants.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation

enum AppConstant {
    enum CellIdentifiers: String {
        case cellIdentifier = "cellIdentifier"
        case productCollectionViewCell = "ProductCollectionViewCell"
    }
    
    static func readJSONFromFile(fileName: String) -> Any? {
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
