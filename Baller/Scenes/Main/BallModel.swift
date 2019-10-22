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

        subscribeIfNeeded()

        self.setupAttemptsCountIfNeeded()
    }

    // MARK: - Properties:

    // MARK: - RxLogic:

    let modelAnswerSubject: PublishSubject<Answer> = PublishSubject()

    lazy var rxAttemptsCount: BehaviorRelay<Int> = BehaviorRelay(value: 0)

    let requestAnswerSubject: PublishSubject<Void> = PublishSubject()
    let modelRequestInProgressSubject: PublishSubject<Bool> = PublishSubject()

    private let disposeBag = DisposeBag()

    private var isLoadingData = false {
        didSet {
            modelRequestInProgressSubject.onNext(isLoadingData)
        }
    }

    // MARK: - Logic:

    func getAnswer(completion: @escaping(Answer) -> Void) {
        isLoadingData = true
        incrementAttemptsCount()

        self.answerService.getAnswer { (result, isLocal) in

            self.isLoadingData = false
            switch result {
            case .success(let answer):
                if !isLocal {
                    self.store.appendAnswer(answer)
                }
                completion(answer)
                self.modelAnswerSubject.onNext(answer)
            case .failure:
                preconditionFailure(L10n.FatalErrors.noLocalAnswer)
            }
        }

    }

    // MARK: - Private:

    // MARK: - RxSubscriptions:

    private var subscribed = false

    private func subscribeIfNeeded() {
        guard subscribed == false else { return }

        rxAttemptsCount
            .asObservable()
            .subscribe { (attemptsCount) in
                print("Model \(attemptsCount)")
        }
        .disposed(by: disposeBag)

        requestAnswerSubject
            .asObservable()
            .subscribe { _ in
                print("BallModel has detected shake.")
        }
        .disposed(by: disposeBag)

        subscribed = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.rxAttemptsCount.accept(self.getAttemptsCount())
        }
    }

// MARK: - Attempts count logic:

    private func incrementAttemptsCount() {
        secureStorage.set(rxAttemptsCount.value, forKey: Keys.shakeAttempts.rawValue)
        rxAttemptsCount.accept(rxAttemptsCount.value + 1)
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
