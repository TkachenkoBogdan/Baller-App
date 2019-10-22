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

    let vmAnswerSubject: PublishSubject<Answer> = PublishSubject()

    let vmAttemptsCount: PublishSubject<Int> = PublishSubject()
    let vmRequestInProgressSubject: PublishSubject<Bool> = PublishSubject()

    var vmTriggerShakeEvent: PublishSubject<Void> = PublishSubject()

    private let disposeBag = DisposeBag()

    init(model: BallModel) {
        self.ballModel = model

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
            .bind(to: self.vmAttemptsCount)
            .disposed(by: disposeBag)

        vmAttemptsCount
            .asObservable()
            .subscribe(onNext: { attempts in
                print("VM received shake count from model \(attempts)")
            })
            .disposed(by: disposeBag)

        // Request in progress:

        ballModel.modelRequestInProgressSubject
                                 .bind(to: vmRequestInProgressSubject)
                                 .disposed(by: disposeBag)

    }

    // MARK: - Observation closures:

//    var requestInProgressHandler: ((Bool) -> Void)? {
//        didSet {
//            ballModel.isLoadingDataStateHandler = requestInProgressHandler
//        }
//    }

    var answerReceivedHandler: ((PresentableAnswer) -> Void)?

    func shakeDetected() {
        ballModel.getAnswer { [unowned self] answer in
            self.answerReceivedHandler?(answer.toPresentableAnswer(uppercased: true))
        }
    }

}
