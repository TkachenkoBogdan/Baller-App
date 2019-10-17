//
//  AnswerProvider.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A common interface abstracting away concrete providers.

protocol AnswerProvider {
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>, _ isLocal: Bool) -> Void)
}

protocol AnswerProviding {
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void)
}

final class AnswerService: AnswerProvider {

    private let onlineProvider: AnswerProviding
    private let offlineProvider: AnswerProviding

    init(onlineProvider: AnswerProviding, offlineProvider: AnswerProviding) {
        self.onlineProvider = onlineProvider
        self.offlineProvider = offlineProvider
    }

    func getAnswer(completionHandler: @escaping (Result<Answer, Error>, _ isLocal: Bool) -> Void) {
        onlineProvider.getAnswer { (result) in
            switch result {
            case .success:
                completionHandler(result, false)
            case .failure:
                self.offlineProvider.getAnswer { (offlineResult) in
                    completionHandler(offlineResult, true)
                }
            }
        }
    }

}
