import Foundation

struct Products: Codable {
	let id: Int
	let title: String
	let price: Double
	let description: String
	let category: String
	let image: String
	let rating: Rating
}

extension Products {
    var formattedPrice: String {
        return "$" + price.description
    }

    var formattedRating: String {
        return "Rating " + rating.rate.description + "/" + "5"
    }
}
