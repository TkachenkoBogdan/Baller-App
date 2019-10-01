//
//  AppDelegate.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {

        let container = DependencyContainer()
        let mainViewController = container.makeBallViewController()

        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        navigationViewController.navigationBar.barStyle = .blackOpaque
        navigationViewController.navigationBar.isTranslucent = false

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        window?.tintColor = ColorName.customPink.color
    }
}
