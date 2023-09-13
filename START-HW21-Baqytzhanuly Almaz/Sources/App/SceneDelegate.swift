//
//  SceneDelegate.swift
//  START-HW21-Baqytzhanuly Almaz
//
//  Created by allz on 9/11/23.
//

import UIKit
import SnapKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: CardsViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
