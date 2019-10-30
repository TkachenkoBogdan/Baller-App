//
//  FlowCoordinator.swift
//  Baller
//
//  Created by Богдан Ткаченко on 28.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

protocol FlowCoordinator: class {

    /// This variable must allways be of 'weak' type.
    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController

}

// MARK: - AppFlowCoordinator:

final class AppFlowCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?

    private let controllerFactory: ViewControllerFactory

    // MARK: - Init:

    init(controllerFactory: ViewControllerFactory, parent: NavigationNode?) {

        self.controllerFactory = controllerFactory
        super.init(parent: parent)
    }

    convenience init(controllerFactory: ViewControllerFactory = AppConfiguration.dependencyContainer) {
        self.init(controllerFactory: controllerFactory, parent: nil)
    }

    // MARK: - Public:

    func createFlow() -> UIViewController {

        let tabBarViewController = BallerTabBarController()
        containerViewController = tabBarViewController

        let ballFlowCoordinator = BallFlowCoordinator(controllerFactory: controllerFactory, parent: self)
        let ballViewController = ballFlowCoordinator.createFlow()

        let historyFlowCoordinator = HistoryFlowCoordinator(controllerFactory: controllerFactory, parent: self)
        let historyViewController = historyFlowCoordinator.createFlow()

        tabBarViewController.viewControllers = [ballViewController, historyViewController]
        return tabBarViewController
    }

}
