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

    private let factory: BallViewControllerFactory

    // MARK: - Init:

    init(factory: BallViewControllerFactory, parent: NavigationNode?) {

        self.factory = factory
        super.init(parent: parent)
    }

    // MARK: - Public:

    func createFlow() -> UIViewController {
        let ballViewController = factory.makeBallViewController(withParent: self)
        let navigationController = UINavigationController(rootViewController: ballViewController)
        self.containerViewController = navigationController

        return navigationController
    }
}
