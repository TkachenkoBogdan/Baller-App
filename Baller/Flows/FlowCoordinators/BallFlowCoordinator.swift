//
//  BallFlowCoordinator.swift
//  Baller
//
//  Created by Богдан Ткаченко on 29.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

// MARK: - BallFlowCoordinator:

final class BallFlowCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?

    private let controllerFactory: BallViewControllerFactory

    // MARK: - Init:

    init(controllerFactory: BallViewControllerFactory, parent: NavigationNode?) {

        self.controllerFactory = controllerFactory
        super.init(parent: parent)
    }

    // MARK: - Public:

    func createFlow() -> UIViewController {
        let ballViewController = controllerFactory.makeBallViewController(withParent: self)
        let navigationController = UINavigationController(rootViewController: ballViewController)
        self.containerViewController = navigationController

        return navigationController
    }
}
