//
//  AnswerProvider.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

protocol AnswerProviding {
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void)
}

class AnswerProvider: AnswerProviding {
    
    private let onlineProvider = OnlineProvider()
    private let offlineProvider = OfflineProvider()
    
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
