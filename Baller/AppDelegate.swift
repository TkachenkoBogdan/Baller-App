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

        window = UIWindow(frame: UIScreen.main.bounds)

        let container = DependencyContainer()
        let mainViewController = container.makeRootRootViewController()

        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        window?.tintColor = AppColor.globalTint
    }
}
