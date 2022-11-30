import Foundation

struct Product: Codable {
	let id: Int
	let title: String
	let price: Double
	let description: String
	let category: String
	let image: String
	let rating: Rating
}

extension Product {
    var formattedPrice: String {
        return AppConstant.Strings.dollarSymbol + price.description
    }

    var formattedRating: String {
        return AppConstant.Strings.rating + rating.rate.description + "/" + AppConstant.Strings.maxRating
    }
}
