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

    private let ballModel: BallModel

    // MARK: - Properties:

    let answer = PublishSubject<PresentableAnswer>()
    let attemptsCount = PublishSubject<Int>()

    let isRequestInProgress = PublishSubject<Bool>()
    let shakeEvent = PublishSubject<Void>()

    // MARK: - Init:

    init(model: BallModel) {
        self.ballModel = model

        setupBindings()
    }

    // MARK: - Private:

    private func setupBindings() {

        // Answer:

        ballModel.answer
            .map { $0.toPresentableAnswer(uppercased: true)}
            .bind(to: answer)
            .disposed(by: disposeBag)

        // Shake event:

        shakeEvent
            .throttle(.seconds(2), latest: true, scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
                self?.ballModel.getAnswer()
            })
            .disposed(by: disposeBag)

        // Attempts count:

        ballModel.attemptsCountRelay
            .bind(to: self.attemptsCount)
            .disposed(by: disposeBag)

        // Request status:

        ballModel.isRequestInProgress
            .bind(to: isRequestInProgress)
            .disposed(by: disposeBag)
    }

}
