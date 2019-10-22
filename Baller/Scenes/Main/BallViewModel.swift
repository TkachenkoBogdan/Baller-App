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

    private let ballModel: BallModel

    var vmAttemptsCount: PublishSubject<Int> = PublishSubject()
    var vmTriggerShakeEvent: PublishSubject<Void> = PublishSubject()

    private let disposeBag = DisposeBag()

    init(model: BallModel) {
        self.ballModel = model

//        self.attemptsCountSub = ballModel
//            .rxAttemptsCount
//            .subscribe(onNext: { value in
//                print(value)
//            })

        setupBindings()
    }

    private func setupBindings() {

        self.vmTriggerShakeEvent
            .bind(to: ballModel.requestAnswerSubject)
            .disposed(by: disposeBag)

        vmTriggerShakeEvent
            .asObservable()
            .subscribe(onNext: {
                print("Shake here in ViewModel!")
            })
            .disposed(by: disposeBag)

        // MARK: - ShowTime:

        ballModel.rxAttemptsCount
            //.filter { $0 % 2 == 0 }
            .bind(to: self.vmAttemptsCount)
            .disposed(by: disposeBag)

        vmAttemptsCount
            .asObservable()
            .subscribe(onNext: { attempts in
                print("VM received shake count from model \(attempts)")
            })
            .disposed(by: disposeBag)

    }

    // MARK: - Observation closures:

    var requestInProgressHandler: ((Bool) -> Void)? {
        didSet {
            ballModel.isLoadingDataStateHandler = requestInProgressHandler
        }
    }

    var answerReceivedHandler: ((PresentableAnswer) -> Void)?

    func shakeDetected() {
        ballModel.getAnswer { [unowned self] answer in
            self.answerReceivedHandler?(answer.toPresentableAnswer(uppercased: true))
        }
    }

}
