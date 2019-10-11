//
//  AnswersViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

typealias Changes = (deletions: [Int], insertions: [Int], modifications: [Int])

final class AnswersListViewModel {

    private let model: AnswerListModel

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    // MARK: - Init:

    init(model: AnswerListModel) {
        self.model = model
    }

    // MARK: - Logic:

    var answerListUpdateHandler: ((ChangeSet<Answer>) -> Void)? {
        didSet {
            model.answerListUpdateHandler = self.answerListUpdateHandler
        }

    }

    // MARK: - Public:

    func count() -> Int {
        return model.numberOfAnswers()
    }

    func answer(at index: Int) -> PresentableAnswer? {
        return model.answer(at: index)?.toPresentableAnswer(withDateFormatter: dateFormatter)
    }

    func appendAnswer(withTitle title: String) {
        model.appendAnswer(with: title)
    }

    func remove(at index: Int) {
        model.remove(at: index)
    }

    func deleteAllAnswers() {
        model.removeAllAnswers()
    }

}
