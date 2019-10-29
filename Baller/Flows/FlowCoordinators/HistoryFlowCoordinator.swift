//
//  HistoryFlowCoordinator.swift
//  Baller
//
//  Created by Богдан Ткаченко on 29.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

// MARK: - HistoryFlowCoordinator:

final class HistoryFlowCoordinator: NavigationNode, FlowCoordinator {

    weak var containerViewController: UIViewController?

    private let factory: AnswersHistoryViewControllerFactory

    // MARK: - Init:

    init(factory: AnswersHistoryViewControllerFactory, parent: NavigationNode?) {

        self.factory = factory
        super.init(parent: parent)
    }

    // MARK: - Public:

    func createFlow() -> UIViewController {
        let historyViewController = factory.makeAnswersHistoryController(withParent: self)
        let navigationController = UINavigationController(rootViewController: historyViewController)
        self.containerViewController = navigationController

        return navigationController
    }
}
