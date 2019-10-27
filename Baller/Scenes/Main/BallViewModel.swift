//
//  MainViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RxSwift
import NSObject_Rx

final class BallViewModel: HasDisposeBag {

    // MARK: - Properties:

    private let ballModel: BallModel

    let answer: PublishSubject<PresentableAnswer> = PublishSubject()
    let attemptsCount: PublishSubject<Int> = PublishSubject()

    let isRequestInProgress: PublishSubject<Bool> = PublishSubject()
    let shakeEventTriggered: PublishSubject<Void> = PublishSubject()

    // MARK: - Init:

    init(model: BallModel) {
        self.ballModel = model

        setupBindings()
    }

    // MARK: - Private:

    private func setupBindings() {

        // Answer binding:

        ballModel.answer
            .map { $0.toPresentableAnswer(uppercased: true)
        }.bind(to: answer)
            .disposed(by: disposeBag)

        // Shake event triggered:

        self.shakeEventTriggered
            .throttle(.seconds(2), latest: true, scheduler: MainScheduler.instance)
            .bind(to: ballModel.answerRequested)
            .disposed(by: disposeBag)

        // Attempts count:

        ballModel.attemptsCountRelay
            .bind(to: self.attemptsCount)
            .disposed(by: disposeBag)

        // Request in progress:

        ballModel.isRequestInProgress
            .bind(to: isRequestInProgress)
            .disposed(by: disposeBag)

    }

}
