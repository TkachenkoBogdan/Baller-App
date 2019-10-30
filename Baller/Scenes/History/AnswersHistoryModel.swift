//
//  AnswersModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import NSObject_Rx

enum AnswerAction {

    case appendAnswer(title: String)
    case deleteAnswer(index: Int)
    case deleteAllAnswers
    case triggerUpdate
}

final class AnswersHistoryModel: NavigationNode, HasDisposeBag {

    private let store: AnswerStore

    let answers = BehaviorRelay<[Answer]>(value: [])
    let actions = PublishSubject<AnswerAction>()

    // MARK: - Init:

    init(parent: NavigationNode?, store: AnswerStore) {
        self.store = store

        super.init(parent: parent)
        store.answersDidUpdateHandler = storeDidUpdateAnswers
        setupActionsSubscription()
    }

    // MARK: - Private:

    private func storeDidUpdateAnswers(_ answers: [Answer]) {
        self.answers.accept(answers)
    }

    private func setupActionsSubscription() {
        actions.subscribe(onNext: { [weak self] action in

            switch action {
            case .appendAnswer(let title):
                self?.store.appendAnswer(Answer(title: title))
            case .deleteAnswer(let index):
                self?.store.removeAnswer(at: index)
            case .deleteAllAnswers:
                self?.store.removeAllAnswers()
            case .triggerUpdate:
                self?.store.provideUpdates()
            }
        })
            .disposed(by: disposeBag)
    }
}
