//
//  DependencyContainer+.swift
//  Baller
//
//  Created by Богдан Ткаченко on 29.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

// MARK: - Interfaces:

protocol BallViewControllerFactory {
    func makeBallViewController(withParent parent: NavigationNode?) -> BallViewController
}

protocol AnswersHistoryViewControllerFactory {
    func makeAnswersHistoryController(withParent parent: NavigationNode?) -> AnswersHistoryController
}

protocol ViewControllerFactory: BallViewControllerFactory, AnswersHistoryViewControllerFactory {}

// MARK: - ViewControllerFactory:

extension DependencyContainer: ViewControllerFactory {

    func makeBallViewController(withParent parent: NavigationNode?) -> BallViewController {

        let ballModel = BallModel(provider: answerService,
                                  store: answerStore,
                                  secureStorage: secureStorage,
                                  parent: parent)

        let ballViewModel = BallViewModel(model: ballModel)

        let ballViewController = BallViewController(viewModel: ballViewModel)
        ballViewController.tabBarItem.image = Asset.ballImage.image
        ballViewController.tabBarItem.title = L10n.BarItemTitles._8ball

        return ballViewController
    }

    func makeAnswersHistoryController(withParent parent: NavigationNode?) -> AnswersHistoryController {

        let answersListModel = AnswersHistoryModel(store: answerStore, parent: parent)
        let answersListViewModel = AnswersHistoryViewModel(model: answersListModel)

        let answersController = AnswersHistoryController(viewModel: answersListViewModel)
        answersController.tabBarItem.image = Asset.defaultAnswers.image
        answersController.tabBarItem.title = L10n.BarItemTitles.history
        return answersController
    }
}
