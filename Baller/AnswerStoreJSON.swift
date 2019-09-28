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

    func answer(at index: Int) -> PersistableAnswer?

    func appendAnswer(_ answer: PersistableAnswer)
    func removeAnswer(at index: Int)

    func count() -> Int

}

/// A concrete class that that can
/// store/retrieve answers from disk and act as a DataSource.

class AnswerStoreJSON {

    private let answerFileName = L10n.Filenames.answerFile
    private let manager: DiskManaging

    private var answers = [PersistableAnswer]() {
        didSet { save() }
    }

    init(storageManager manager: DiskManaging) {
        self.manager = manager
        if !manager.fileExists(answerFileName, in: .documents) {
            self.answers = defaultAnswers()
            save()
        } else {
            self.answers = manager.retrieve(answerFileName,
                                            from: .documents,
                                            as: [PersistableAnswer].self) ?? [PersistableAnswer]()
        }
    }

    /// Saves all answers to the disk atomically:
    private func save() {
        manager.store(self.answers, to: .documents, as: answerFileName)
    }

    /// Fetches default set of answers included in the bundle:
    private func defaultAnswers () -> [PersistableAnswer] {

        guard let answers = manager.pathInBundle(L10n.Filenames.defaultAnswers),
            let answersData = try? Data(contentsOf: answers),
            let defaultAnswers = try? JSONDecoder().decode([PersistableAnswer].self, from: answersData) else {
                preconditionFailure("Failed to decode a valid set of answers from the bundle.")
        }

        return defaultAnswers
    }
}

// MARK: - AnswerStore Protocol Conformance:

extension AnswerStoreJSON: AnswerStore {

    func answer(at index: Int) -> PersistableAnswer? {
        if 0..<answers.count ~= index {
            return answers[index]
        }
        return nil
    }

    func count() -> Int {
        return answers.count
    }

    func appendAnswer(_ answer: PersistableAnswer) {
        self.answers.append(answer)
    }

    func removeAnswer(at index: Int) {
        if 0..<answers.count ~= index {
            answers.remove(at: index)
        }
    }

}
