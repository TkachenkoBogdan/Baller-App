//
//  OfflineAnswerService.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A concrete provider that fetches answers from a local storage.

struct OfflineAnswerProvider: AnswerProviding {

    enum OfflineServiceError: Error {
        case unknownError
    }

    private let store: AnswerStore

    init(with store: AnswerStore) {
        self.store = store
    }

    func getAnswer(completionHandler: @escaping (Result<PersistableAnswer, Error>) -> Void) {
        if let answer = getRandomAnswer() {
            completionHandler(Result.success(answer))
        } else {
            completionHandler(Result.failure(OfflineServiceError.unknownError))
        }
    }

    private func getRandomAnswer() -> PersistableAnswer? {

        let randomIndex = Int.random(in: 0..<store.count())
        return store.answer(at: randomIndex)
    }
}
