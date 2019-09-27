//
//  MainViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class MainScreenViewModel {

    private let answerProvider: AnswerProviding

    init(answerProvider provider: AnswerProviding) {
        self.answerProvider = provider
    }

    func getAnswer(completion: @escaping (_ answer: String) -> Void) {

        self.answerProvider.getAnswer { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let answer):
                    completion(answer.title)
                case .failure:
                    completion ("Oh, snap! Try again")
                }
            }
        }

    }

}
