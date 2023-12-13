//
//  SceneDelegate.swift
//  Gismeteo
//
//  Created by Constantin on 22.11.2023.
//

import UIKit

// MARK: - SceneDelegate

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	// MARK: - Internal properties

	var window: UIWindow?

	// MARK: - Internal methods

	func scene(
		_ scene: UIScene,
		willConnectTo _: UISceneSession,
		options _: UIScene.ConnectionOptions
	) {
		guard let winScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: winScene)
		window.rootViewController = UINavigationController(rootViewController: MainAssembler().assembly(isMain: true))

		#if DEBUG
			if ProcessInfo.processInfo.arguments.contains("-launchWithFindScene") {
				window.rootViewController = UINavigationController(rootViewController: FindAssembler().assembly(weatherModel: []))
			}
		#endif

		window.makeKeyAndVisible()
		self.window = window
	}
}
