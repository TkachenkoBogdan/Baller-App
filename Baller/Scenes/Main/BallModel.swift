//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class BallModel {

    private enum Keys: String {
        case shakeAttempts
    }

    // MARK: - Dependencies:

    private let answerService: AnswerProvider
    private let secureStorage: SecureStoring
    private let store: AnswerStore

    // MARK: - Init:

    init(provider: AnswerProvider, store: AnswerStore, secureStorage: SecureStoring) {
        self.answerService = provider
        self.secureStorage = secureStorage
        self.store = store

        setupAttemptsCountIfNeeded()
        setupRxSubscription()
    }

    // MARK: - Properties:

    let modelAnswerSubject: PublishSubject<Answer> = PublishSubject()
    let modelAnswerRequestedSubject: PublishSubject<Void> = PublishSubject()
    let modelRequestInProgressSubject: PublishSubject<Bool> = PublishSubject()

    private(set) lazy var attemptsCountRelay: BehaviorRelay<Int> = BehaviorRelay(value: 0)

    private let disposeBag = DisposeBag()

    private var isLoadingData = false {
        didSet {
            modelRequestInProgressSubject.onNext(isLoadingData)
        }
    }

    // MARK: - Public Logic:

    func getAnswer() {
        isLoadingData = true
        incrementAttemptsCount()

        self.answerService.getAnswer { (result, isLocal) in

            self.isLoadingData = false
            switch result {
            case .success(let answer):
                if !isLocal {
                    self.store.appendAnswer(answer)
                }
                self.modelAnswerSubject.onNext(answer)
            case .failure:
                preconditionFailure(L10n.FatalErrors.noLocalAnswer)
            }
        }
    }

    // MARK: - Private:

    private func setupRxSubscription() {

        //Subscription to answer subject:

        modelAnswerRequestedSubject
            .subscribe { _ in
                self.getAnswer()
        }.disposed(by: disposeBag)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.attemptsCountRelay.accept(self.getAttemptsCount())
        }
    }

    // MARK: - Attempts count logic:

    private func incrementAttemptsCount() {
        attemptsCountRelay.accept(attemptsCountRelay.value + 1)
        secureStorage.set(attemptsCountRelay.value, forKey: Keys.shakeAttempts.rawValue)
    }

    private func getAttemptsCount() -> Int {
        guard let count = secureStorage.value(forKey: Keys.shakeAttempts.rawValue) else {
            return 0
        }
        return count
    }

    private func setupAttemptsCountIfNeeded() {
        guard (secureStorage.value(forKey: Keys.shakeAttempts.rawValue)) != nil else {
            secureStorage.set(0, forKey: Keys.shakeAttempts.rawValue)
            return
        }
    }

}
