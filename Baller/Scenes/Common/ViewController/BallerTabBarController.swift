//
//  BallerTabBarController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 17.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class BallerTabBarController: UITabBarController {

    private lazy var animationController: UIViewControllerAnimatedTransitioning = {
        return SlideAnimationController(viewControllers: viewControllers)
    }()

    // MARK: - Lifecycle:

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        tabBar.isTranslucent = false
    }
}

extension BallerTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animationController
    }
}
