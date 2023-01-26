//
//  SceneDelegate.swift
//  PumpkinHotel
//
//  Created by Никита Иващенков on 01.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator.start()
        self.window = window
    }
}

