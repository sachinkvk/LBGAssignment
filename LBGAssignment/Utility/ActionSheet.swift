//
//  ActionSheet.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 24/11/22.
//

import Foundation
import UIKit

class ActionSheet {
    static func showActionsheet(viewController: UIViewController, title: String,
                                message: String, actions: [(String, UIAlertAction.Style, SortingTypes)],
                                completion: @escaping (_ type: SortingTypes) -> Void) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (_ , (title, style, type)) in actions.enumerated() {
        let alertAction = UIAlertAction(title: title, style: style) { (_) in
            completion(type)
        }
        alertViewController.addAction(alertAction)
     }
     viewController.present(alertViewController, animated: true, completion: nil)
    }
}
