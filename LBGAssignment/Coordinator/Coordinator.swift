//
//  Coordinator.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 30/11/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
