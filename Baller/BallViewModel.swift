//
//  MainViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

final class BallViewModel {

    private let ballModel: BallModel

    init(model: BallModel) {
        self.ballModel = model
    }

    // MARK: - Observation closures:

    var shouldAnimateLoadingStateHandler: ((Bool) -> Void)? {
        didSet {
            ballModel.isLoadingDataStateHandler = shouldAnimateLoadingStateHandler
        }
    }

    var answerReceivedHandler: ((PresentableAnswer) -> Void)?

    func shakeDetected() {
        ballModel.getAnswer { [unowned self] answer in
            self.answerReceivedHandler?(answer.toPresentableAnswer(uppercased: true))
        }
    }

}
