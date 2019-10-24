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

final class AnswerListModel {

    private let store: AnswerStore

    let changeListSubject: PublishSubject<ChangeSet<Answer>> = PublishSubject()
    let modelChangeActionSubject: PublishSubject<AnswerAction> = PublishSubject()

    let answerSubject: BehaviorRelay<[Answer]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()

    // MARK: - Init:

    init(store: AnswerStore) {
        self.store = store
        store.answerListUpdateHandler = self.answerListUpdateHandler
        setupRxSubscriptions()
    }

    lazy var answerListUpdateHandler: ((ChangeSet<Answer>) -> Void)? = { changeSet in
       // self.changeListSubject.onNext(changeSet)
        self.answerSubject.accept(self.store.allAnswers())
    }

    // MARK: - To solve:

//    func numberOfAnswers() -> Int {
//        return store.count
//    }
//
//    func answer(at index: Int) -> Answer? {
//        return store.answer(at: index)
//    }

    ///////////////////////

    // MARK: - Private:

    private func setupRxSubscriptions() {

        //Changes:
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
