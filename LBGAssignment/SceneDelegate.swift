//
//  SceneDelegate.swift
//  LBGAssignment
//
//  Created by Sachin Panigrahi on 20/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
        self.window = UIWindow.init(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
