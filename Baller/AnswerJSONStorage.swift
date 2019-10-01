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

final class AnswerJSONStorage {

    private let answerFileName = L10n.Filenames.answerFile
    private let fileDataManager: FileDataManageable

    private var answers = [SerializableAnswer]() {
        didSet { save() }
    }

    init(storageManager fileDataManager: FileDataManageable) {
        self.fileDataManager = fileDataManager
        if !fileDataManager.fileExists(answerFileName, in: .documents) {
            self.answers = defaultAnswers()
            save()
        } else {
            self.answers = fileDataManager.retrieve(answerFileName,
                                            from: .documents,
                                            as: [SerializableAnswer].self) ?? [SerializableAnswer]()
        }
    }

    /// Saves all answers to the disk atomically:
    private func save() {
        fileDataManager.store(self.answers, to: .documents, as: answerFileName)
    }

    /// Fetches default set of answers included in the bundle:
    private func defaultAnswers () -> [SerializableAnswer] {

        guard let answers = fileDataManager.pathInBundle(L10n.Filenames.defaultAnswers),
            let answersData = try? Data(contentsOf: answers),
            let defaultAnswers = try? JSONDecoder().decode([SerializableAnswer].self, from: answersData) else {
                preconditionFailure("Failed to decode a valid set of answers from the bundle.")
        }

        return defaultAnswers
    }
}

// MARK: - AnswerStore Protocol Conformance:

extension AnswerJSONStorage: AnswerStore {

    func answer(at index: Int) -> Answer? {
        if 0..<answers.count ~= index {
            return answers[index].toAnswer()
        }
        return nil
    }

    func count() -> Int {
        return answers.count
    }

    func appendAnswer(_ answer: Answer) {
        self.answers.append(answer.toPersistableAnswer())
    }

    func removeAnswer(at index: Int) {
        if 0..<answers.count ~= index {
            answers.remove(at: index)
        }
    }

}
