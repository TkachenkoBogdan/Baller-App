//
//  DependencyContainer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

protocol BallViewControllerFactory {
    func makeBallViewController(withParent parent: NavigationNode?) -> BallViewController
}

protocol AnswersHistoryViewControllerFactory {
    func makeAnswersHistoryController(withParent parent: NavigationNode?) -> AnswersHistoryController
}

protocol ViewControllerFactory: BallViewControllerFactory, AnswersHistoryViewControllerFactory {}

final class DependencyContainer {

    private lazy var answerService: AnswerProvider =
        AnswerService(onlineProvider: NetworkAnswerProvider(),
                      offlineProvider: DatabaseAnswerProvider(store: answerStore))

    private lazy var answerStore: AnswerStore = RealmAnswerStore(realmProvider: .default)
    private lazy var secureStorage: SecureStoring = SecureStorage()
}

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
