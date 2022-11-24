//
//  ProductDetailsViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import UIKit
import SDWebImage

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak private var productTitle: UILabel!
    @IBOutlet weak private var productImageView: UIImageView!
    @IBOutlet weak private var productCategory: UILabel!

    var productDetailsViewModel: ProductDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = productDetailsViewModel?.screenTitle
        productImageView.sd_setImage(with: URL(string: productDetailsViewModel?.product.image ?? ""))
        productTitle.text = productDetailsViewModel?.product.title
        productCategory.text = productDetailsViewModel?.product.category
    }

}
