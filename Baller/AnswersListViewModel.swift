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
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    init(model: AnswerListModel) {
        self.model = model
    }

    func count() -> Int {
        return model.numberOfAnswers()
    }

    func answer(at index: Int) -> PresentableAnswer? {
        return model.answer(at: index)?.toPresentableAnswer(withDateFormatter: dateFormatter)
    }

    func appendAnswer(withTitle title: String) {
        self.model.appendAnswer(with: title)
    }

    func remove(at index: Int) {
         self.model.remove(at: index)
    }

}
