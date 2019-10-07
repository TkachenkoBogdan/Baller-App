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

final class DependencyContainer {

    private lazy var answerService: AnswerProvider =
        AnswerService(onlineProvider: NetworkAnswerProvider(),
                      offlineProvider: DatabaseAnswerProvider(store: answerStore))

    private lazy var answerStore: AnswerStore = AnswerJSONStorage(storageManager: storage)

    private lazy var storage: FileDataManageable = FileDataManager()
    private lazy var secureStorage: SecureStoring = SecureStorage()
}

extension DependencyContainer: ViewControllerFactory {

    func makeBallViewController() -> BallViewController {

        let ballModel = BallModel(provider: answerService, secureStorage: secureStorage)
        let ballViewModel = BallViewModel(model: ballModel)

        let mainController = BallViewController(viewModel: ballViewModel,
                                                factory: self as AnswersListViewControllerFactory)
        return mainController
    }

    func makeAnswersListController() -> AnswersListController {

        let answersListModel = AnswerListModel(store: answerStore)
        let answersListViewModel = AnswersListViewModel(model: answersListModel)

        let answersController = AnswersListController(viewModel: answersListViewModel)

        return answersController
    }
}
