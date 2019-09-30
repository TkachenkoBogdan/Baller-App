//
//  AnswerProvider.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

/// A common interface abstracting away concrete providers.

protocol AnswerService {
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void)
}

final class AnswerProvider: AnswerService {

    private let onlineProvider: AnswerService
    private let offlineProvider: AnswerService

    init(onlineProvider: AnswerService, offlineProvider: AnswerService) {
        self.onlineProvider = onlineProvider
        self.offlineProvider = offlineProvider
    }

    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void) {
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
