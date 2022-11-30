//
//  ProductCollectionViewCell.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var productRating: UILabel!
    @IBOutlet weak private var productPrice: UILabel!
    @IBOutlet weak private var productName: UILabel!

    var product: Product? {
        didSet {
            guard let product = product else {  return }
            guard let url = URL(string: product.image) else { return }
            productImageView.sd_setImage(with: url)
            productName.text = product.title
            productPrice.text = product.formattedPrice
            productRating.text = product.formattedRating
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = AppConstant.CellProperties.cornerRadius
        containerView.layer.borderColor = AppConstant.CellProperties.borderColor
        containerView.layer.borderWidth = AppConstant.CellProperties.borderWidth
    }
}
