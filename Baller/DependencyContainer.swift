//
//  DependencyContainer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

protocol BallViewControllerFactory {
    func makeBallViewController() -> BallViewController
}

protocol AnswersListViewControllerFactory {
    func makeAnswersListController() -> AnswersListController
}

protocol ViewControllerFactory: BallViewControllerFactory, AnswersListViewControllerFactory {}

final class DependencyContainer {

    private lazy var answerService: AnswerProvider =
        AnswerService(onlineProvider: NetworkAnswerProvider(),
                      offlineProvider: DatabaseAnswerProvider(store: answerStore))

    private lazy var answerStore: AnswerStore = AnswerJSONStorage(storageManager: storage)

    private lazy var storage: FileDataManageable = FileDataManager()
    private lazy var secureStorage: SecureStoring = SecureStorage()
}

extension DependencyContainer: ViewControllerFactory {

    func makeRootRootViewController() -> UITabBarController {
        let rootViewController = UITabBarController()

        let firstTabController = UINavigationController(rootViewController: makeBallViewController())
        let secondTabController = UINavigationController(rootViewController: (makeAnswersListController()))

        rootViewController.viewControllers = [firstTabController, secondTabController]
        return rootViewController
    }

    func makeBallViewController() -> BallViewController {

        let ballModel = BallModel(provider: answerService, secureStorage: secureStorage)
        let ballViewModel = BallViewModel(model: ballModel)

        let ballViewController = BallViewController(viewModel: ballViewModel)
        ballViewController.tabBarItem.image = Asset.ballImage.image
        ballViewController.tabBarItem.title = L10n.BarItemTitles._8ball

        return ballViewController
    }

    func makeAnswersListController() -> AnswersListController {

        let answersListModel = AnswerListModel(store: answerStore)
        let answersListViewModel = AnswersListViewModel(model: answersListModel)

        let answersController = AnswersListController(viewModel: answersListViewModel)
        answersController.tabBarItem.image = Asset.defaultAnswers.image
        answersController.tabBarItem.title = L10n.BarItemTitles.history
        return answersController
    }
}
