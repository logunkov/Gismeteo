//
//  SceneDelegate.swift
//  Gismeteo
//
//  Created by Constantin on 22.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo _: UISceneSession,
		options _: UIScene.ConnectionOptions
	) {
		// Проверяем, что сцена является окном.
		guard let winScene = (scene as? UIWindowScene) else { return }

		// Устанавливаем корневой контроллер.
		let window = UIWindow(windowScene: winScene)
		window.rootViewController = UINavigationController(rootViewController: ViewController())
		window.makeKeyAndVisible()
		self.window = window
	}
}
