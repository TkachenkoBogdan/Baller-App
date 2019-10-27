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

final class AnswerListModel: HasDisposeBag {

    private let store: AnswerStore

    let answerSubject: BehaviorRelay<[Answer]> = BehaviorRelay(value: [])
    let modelChangeActionSubject: PublishSubject<AnswerAction> = PublishSubject()

    // MARK: - Init:

    init(store: AnswerStore) {
        self.store = store
        store.answersDidUpdateHandler = storeDidUpdateAnswers
        setupSubscriptions()
    }

    private func storeDidUpdateAnswers(_ answers: [Answer]) {
        self.answerSubject.accept(answers)
    }

    // MARK: - Private:

    private func setupSubscriptions() {

        modelChangeActionSubject
            .subscribe(onNext: { action in
                switch action {
                case .appendAnswer(let title):
                    self.store.appendAnswer(Answer(title: title))
                case .deleteAnswer(let index):
                    self.store.removeAnswer(at: index)
                case .deleteAllAnswers:
                    self.store.removeAllAnswers()
                }
            })
            .disposed(by: disposeBag)
    }
}
