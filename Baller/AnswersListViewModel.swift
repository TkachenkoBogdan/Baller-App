//
//  AnswersViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

final class AnswersListViewModel {

    private let model: AnswerListModel

    init(model: AnswerListModel) {
        self.model = model
    }

    func count() -> Int {
        return model.numberOfAnswers()
    }

    func answer(at index: Int) -> PresentableAnswer? {
        return model.answer(at: index)?.toPresentableAnswer()
    }

    func itemDeleted(at index: Int) {
        removeAnswer(at: index)
    }

    func itemAppended(withTitle title: String) {
        self.model.appendAnswer(Answer(withTitle: title))
    }

    private func removeAnswer(at index: Int) {
        self.model.remove(at: index)
    }

}
