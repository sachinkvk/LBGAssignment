//
//  UIViews.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 25/11/22.
//

import Foundation
import UIKit

protocol ActivityDisplayable {
    func showLoader()
    func hideLoader()
}

extension UIView: ActivityDisplayable {
    func showLoader() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.center
        activityView.tag = 101
        activityView.startAnimating()
        self.addSubview(activityView)
    }

    func hideLoader() {
        if let view = viewWithTag(101) {
            view.removeFromSuperview()
        }
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
