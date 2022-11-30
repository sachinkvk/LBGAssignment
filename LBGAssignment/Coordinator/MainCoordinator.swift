//
//  MainCoordinator.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 30/11/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let viewController = ProductListViewController.instantiate(appStoryboard: .main)
                                as? ProductListViewController {
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    func productDetails(_ product: Product) {
        if let viewController = ProductDetailsViewController.instantiate(appStoryboard: .main)
                                as? ProductDetailsViewController {
            viewController.productDetailsViewModel = ProductDetailsViewModel(product: product)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
