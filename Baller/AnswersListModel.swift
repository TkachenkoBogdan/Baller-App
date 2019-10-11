//
//  AnswersModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

final class AnswerListModel {

    private let store: AnswerStore

    init(store: AnswerStore) {
        self.store = store
    }

    var answerListUpdateHandler: ((ChangeSet<Answer>) -> Void)? {
        didSet {
            store.answerListUpdateHandler = self.answerListUpdateHandler
        }

    }

    func numberOfAnswers() -> Int {
        return store.count()
    }

    func answer(at index: Int) -> Answer? {
        return store.answer(at: index)
    }

    func appendAnswer(with title: String) {
        let answer = Answer(title: title)
        self.store.appendAnswer(answer)
    }

    func remove(at index: Int) {
        self.store.removeAnswer(at: index)
    }

    func removeAllAnswers() {
        store.removeAllAnswers()
    }

}
