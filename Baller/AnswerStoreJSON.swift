//
//  JSONStore.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A common interface for objects that are able to act as a data source.

protocol AnswerStore {

    func answer(at index: Int) -> Answer?

    func appendAnswer(_ answer: Answer)
    func removeAnswer(at index: Int)

    func count() -> Int

}

/// A concrete class that that can
/// store/retrieve answers from disk and act as a DataSource.

class AnswerStoreJSON {

    private let answerFileName = L10n.Filenames.answerFile

    private var answers = [Answer]() {
        didSet { save() }
    }

    init() {

        if !Storage.fileExists(answerFileName, in: .documents) {
            self.answers = defaultAnswers()
            save()
        } else {
            self.answers = Storage.retrieve(answerFileName,
                                            from: .documents,
                                            as: [Answer].self) ?? [Answer]()
        }
    }

    /// Saves all asnwers atomically to the disk:
    private func save() {
        Storage.store(self.answers, to: .documents, as: answerFileName)
    }

    /// Fetches default set of answers included in the bundle:
    private func defaultAnswers () -> [Answer] {

        guard let answers = Storage.pathInBundle(L10n.Filenames.defaultAnswers),
            let answersData = try? Data(contentsOf: answers),
            let defaultAnswers = try? JSONDecoder().decode([Answer].self, from: answersData) else {
                preconditionFailure("Failed to decode a valid set of answers from the bundle.")
        }

        return defaultAnswers
    }
}

// MARK: - AnswerStore Protocol Conformance:

extension AnswerStoreJSON: AnswerStore {

    func answer(at index: Int) -> Answer? {
        if 0..<answers.count ~= index {
            return answers[index]
        }
        return nil
    }

    func count() -> Int {
        return answers.count
    }

    func appendAnswer(_ answer: Answer) {
        self.answers.append(answer)
    }

    func removeAnswer(at index: Int) {
        if 0..<answers.count ~= index {
            answers.remove(at: index)
        }
    }

}
