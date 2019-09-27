//
//  MainViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class BallViewModel {

    private let ballModel: BallModel

    init(model: BallModel) {
        self.ballModel = model
    }

    var shouldAnimateLoadingStateHandler: ((Bool) -> Void)? {
        didSet {
            ballModel.isLoadingDataStateHandler = shouldAnimateLoadingStateHandler
        }
    }

    func getAnswer(completion: @escaping (_ answer: String) -> Void) {
        ballModel.getAnswer { (answer) in
            completion(answer.title)
        }
    }

}
