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
        let mainVC = container.makeBallViewController()

        let navVC = UINavigationController(rootViewController: mainVC)
        navVC.navigationBar.barStyle = .blackOpaque
        navVC.navigationBar.isTranslucent = false

        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        window?.tintColor = ColorName.customPink.color
    }
}
