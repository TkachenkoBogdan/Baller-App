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

    let answerProvider: AnswerProviding =
         AnswerProvider(onlineProvider: OnlineAnswerProvider(),
                       offlineProvider: OfflineAnswerProvider(with: AnswerStoreJSON()))

    func applicationDidFinishLaunching(_ application: UIApplication) {

        window = UIWindow.init(frame: UIScreen.main.bounds)

        let mainVC = BallViewController.instantiate()

        let model = BallModel(with: answerProvider)
        mainVC.viewModel = BallViewModel(model: model)

        let navVC = UINavigationController(rootViewController: mainVC)
        navVC.navigationBar.barStyle = .blackOpaque
        navVC.navigationBar.isTranslucent = false

        window?.rootViewController = navVC
        window?.makeKeyAndVisible()

    }
}
