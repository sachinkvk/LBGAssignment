//
//  UIViewContolller+Extension.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation
import UIKit

enum AppStoryboard: String {
   case main = "Main"
   case profile = "Profile"
}

extension UIViewController {
    
    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}

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
}
