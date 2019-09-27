//
//  AnswersViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class AnswersListViewModel {

    private let model: AnswerListModel

    init(model: AnswerListModel) {
        self.model = model
    }

    func count() -> Int {
        return model.numberOfAnswers()
    }

    func answer(at index: Int) -> PresentableAnswer? {
        let answer = model.answer(at: index)?.toPresentableAnswer()

        return answer
    }

    func removeAnswer(at index: Int) {
        self.model.remove(at: index)
    }
}
