//
//  AnswerProvider.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A common interface abstracting away concrete providers.

protocol AnswerProviding {
    func getAnswer(completionHandler: @escaping (Result<PersistableAnswer, Error>) -> Void)
}

final class AnswerProvider: AnswerProviding {

    private let onlineProvider: AnswerProviding
    private let offlineProvider: AnswerProviding

    init(onlineProvider: AnswerProviding, offlineProvider: AnswerProviding) {
        self.onlineProvider = onlineProvider
        self.offlineProvider = offlineProvider
    }

    func getAnswer(completionHandler: @escaping (Result<PersistableAnswer, Error>) -> Void) {
        onlineProvider.getAnswer { (result) in
            switch result {
            case .success:
                completionHandler(result)
            case .failure:
                self.offlineProvider.getAnswer { (offlineResult) in
                    completionHandler(offlineResult)
                }
            }
        }
    }

}
