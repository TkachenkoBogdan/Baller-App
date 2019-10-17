//
//  OfflineAnswerService.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A concrete provider that fetches answers from a local storage.

struct DatabaseAnswerProvider: AnswerProviding {

    enum OfflineServiceError: Error {
        case failedToRetrieveLocalAnswer
    }

    private let store: AnswerStore

    init(store: AnswerStore) {
        self.store = store
    }

    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void) {
        if let answer = getRandomLocalAnswer() {
            completionHandler(Result.success(answer))
        } else {
            completionHandler(Result.failure(OfflineServiceError.failedToRetrieveLocalAnswer))
        }
    }

    private func getRandomLocalAnswer() -> Answer? {
        guard !store.isEmpty else {
            return Answer(title: L10n.noDefaultAnswers)
        }
        let randomIndex = Int.random(in: 0..<store.count)
        return store.answer(at: randomIndex)
    }
}
