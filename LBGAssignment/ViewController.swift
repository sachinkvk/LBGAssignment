//
//  ViewController.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 20/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Task {
            let result = await WebService.sharedInstance.fetch(with: RequestTypes.allProducts.request,
                                                               decodingType: [Products].self)
            print(result)
        }
    }
}

