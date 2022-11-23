//
//  ProductViewModel.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 23/11/22.
//

import Foundation

struct ProductViewModel {
    let imageName: String
    let title: String
    let desc: String
    let price: Double
    let rating: Double
    let category: String
    
    var formattedPrice: String {
        return "$ " + price.description
    }
    
    var formattedRating: String {
        return "Rating " + rating.description + "/" + "5"
    }
}
