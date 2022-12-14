//
//  UIViewContolller+Extension.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 22/11/22.
//

import Foundation
import UIKit

extension UIViewController {

    class func instantiate<T: UIViewController>(appStoryboard: AppConstant.Storyboards) -> T? {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}
