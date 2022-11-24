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
    
    var productViewModel: Products? {
        didSet {
            guard let product = productViewModel else {  return }
            guard let url = URL(string: product.image) else { return }
            productImageView.sd_setImage(with: url)
            productName.text = product.title
            productPrice.text = product.formattedPrice
            productRating.text = product.formattedRating
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 1
        containerView.layer.borderColor = UIColor.brown.cgColor
        containerView.layer.borderWidth = 0.5
    }
}


