//
//  ProductDetailsViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit
import SDWebImage

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productCategory: UILabel!
    var productDetailsViewModel: ProductDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Details"
        productImageView.sd_setImage(with: URL(string: productDetailsViewModel?.product.image ?? ""))
        productTitle.text = productDetailsViewModel?.product.title
        productCategory.text = productDetailsViewModel?.product.category
    }

}
