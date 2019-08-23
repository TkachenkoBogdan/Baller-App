//
//  OfflineAnswerService.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

struct OfflineProvider: AnswerProviding {
    
    enum OfflineServiceError: Error {
        case unknownError
    }
    
    private let store: AnswerStore = JSONStore.shared
    
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void) {
        if let answer = getRandomAnswer() {
            completionHandler(Result.success(answer))
        } else {
            completionHandler(Result.failure(OfflineServiceError.unknownError))
        }
    }
    
   
    
    private func getRandomAnswer() -> Answer? {
        let answers = store.allAnswers()
        return answers.randomElement()
    }
}
