//
//  AnswersModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class AnswerListModel {

    private let store: AnswerStore
//    private var answers: [Answer] = []

    init(with store: AnswerStore) {
        self.store = store
    }

    func appendAnswer(_ answer: PersistableAnswer) {
        self.store.appendAnswer(answer)
    }

    func numberOfAnswers() -> Int {
        return store.count()
    }

    func answer(at index: Int) -> Answer? {
        return store.answer(at: index)?.toAnswer()
    }

    func remove(at index: Int) {
        self.store.removeAnswer(at: index)
    }

}
