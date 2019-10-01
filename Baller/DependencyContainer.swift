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

}

extension DependencyContainer: ViewControllerFactory {

    func makeBallViewController() -> BallViewController {

        let ballModel = BallModel(provider: answerService)
        let ballViewModel = BallViewModel(model: ballModel)

        let mainController = BallViewController(viewModel: ballViewModel,
                                                factory: self as AnswersListViewControllerFactory)
        return mainController
    }

    func makeAnswersListController() -> AnswersListController {

        let answersListModel = AnswerListModel(store: answerStore)
        let answersListViewModel = AnswersListViewModel(model: answersListModel)

        let answersController = StoryboardScene.Main.answersListController.instantiate()
        answersController.viewModel = answersListViewModel
        return answersController
    }

}
