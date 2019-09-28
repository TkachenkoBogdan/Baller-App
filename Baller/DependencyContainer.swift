//
//  DependencyContainer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

protocol BallViewControllerFactory {
    func makeBallViewController() -> BallViewController
}

protocol AnswersListViewControllerFactory {
    func makeAnswersListController() -> AnswersListController
}

protocol ViewControllerFactory: BallViewControllerFactory, AnswersListViewControllerFactory {}

class DependencyContainer {

    private lazy var storage: DiskManaging = Storage()
    private lazy var answerStore: AnswerStore = AnswerStoreJSON(storageManager: storage)

    private lazy var answerProvider: AnswerProviding =
     AnswerProvider(onlineProvider: OnlineAnswerProvider(),
                   offlineProvider: OfflineAnswerProvider(with: answerStore))

}

extension DependencyContainer: ViewControllerFactory {

    func makeBallViewController() -> BallViewController {

        let ballModel = BallModel(with: answerProvider)
        let ballViewModel = BallViewModel(model: ballModel)

        let mainController = BallViewController.instantiate()
        mainController.viewModel = ballViewModel
        mainController.factory = self as AnswersListViewControllerFactory
        return mainController
    }

    func makeAnswersListController() -> AnswersListController {

        let answersListModel = AnswerListModel(with: answerStore)
        let answersListViewModel = AnswersListViewModel(model: answersListModel)

        let answersController = AnswersListController.instantiate()
        answersController.viewModel = answersListViewModel
        return answersController
    }

}
