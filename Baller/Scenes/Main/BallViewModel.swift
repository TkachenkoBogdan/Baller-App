//
//  MainViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RxSwift

final class BallViewModel {

    // MARK: - Properties:

    private let ballModel: BallModel

    let vmAnswerSubject: PublishSubject<PresentableAnswer> = PublishSubject()

    let vmAttemptsCount: PublishSubject<Int> = PublishSubject()
    let vmRequestInProgressSubject: PublishSubject<Bool> = PublishSubject()

    var shakeEventTriggered: PublishSubject<Void> = PublishSubject()

    private let disposeBag = DisposeBag()

    // MARK: - Init:

    init(model: BallModel) {
        self.ballModel = model

        setupBindings()
    }

    // MARK: - Private:

    private func setupBindings() {
        // Answer binding:

        ballModel.modelAnswerSubject
            .map { $0.toPresentableAnswer(uppercased: true)
        }.bind(to: vmAnswerSubject)
            .disposed(by: disposeBag)

        // Shake event triggered:

        self.shakeEventTriggered
            .bind(to: ballModel.modelAnswerRequestedSubject)
            .disposed(by: disposeBag)

        // Attempts count:

        ballModel.attemptsCountRelay
            .bind(to: self.vmAttemptsCount)
            .disposed(by: disposeBag)

        // Request in progress:

        ballModel.modelRequestInProgressSubject
            .bind(to: vmRequestInProgressSubject)
            .disposed(by: disposeBag)

    }

}
