//
//  SceneDelegate.swift
//  MulticolorScreen
//
//  Created by Marat Shagiakhmetov on 04.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneDelegate = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: sceneDelegate)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: BackgroundViewController())
    }
}

