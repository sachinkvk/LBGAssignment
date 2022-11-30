//
//  AppConstants.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation
import UIKit

enum ServiceUrl {
    static let baseURL = "https://fakestoreapi.com"
    static let mockURL = "https://fakestoreapi.com/products"

    enum EndPoints {
        static let allProducts = "/products"
    }
}

struct AppConstant {
    enum Storyboards: String {
       case main = "Main"
    }

    struct CellProperties {
        static let noOfItemsInRow: CGFloat = 2
        static let leftRightPaddings: CGFloat = 10
        static let cornerRadius: CGFloat = 1
        static let borderWidth: CGFloat = 0.5
        static let borderColor = UIColor.brown.cgColor
    }

    struct CellPadding {
        static let top: CGFloat = 5
        static let bottom: CGFloat = 0
        static let left: CGFloat = 5
        static let right: CGFloat = 5
    }

    struct Strings {
        static let rating = "Rating "
        static let maxRating = "5"
        static let dollarSymbol = "$"
    }
}
