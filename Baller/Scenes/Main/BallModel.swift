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
import NSObject_Rx

final class BallModel: NavigationNode, HasDisposeBag {

    private enum Keys: String {
        case shakeAttempts
    }

    // MARK: - Dependencies:

    private let answerService: AnswerProvider
    private let secureStorage: SecureStoring
    private let store: AnswerStore

    // MARK: - Properties:

    let answer: PublishSubject<Answer> = PublishSubject()
    let isRequestInProgress: PublishSubject<Bool> = PublishSubject()

    private(set) var attemptsCountRelay: BehaviorRelay<Int> = BehaviorRelay(value: 0)

    private var isLoadingData = false {
        didSet {
            isRequestInProgress.onNext(isLoadingData)
        }
    }

    // MARK: - Init:

    init(provider: AnswerProvider, store: AnswerStore, secureStorage: SecureStoring, parent: NavigationNode?) {
        self.answerService = provider
        self.secureStorage = secureStorage
        self.store = store

        super.init(parent: parent)
        setupAttemptsCount()
    }

    // MARK: - Public:

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
                self.answer.onNext(answer)
            case .failure:
                preconditionFailure(L10n.FatalErrors.noLocalAnswer)
            }
        }
    }

    // MARK: - Private:

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

    private func setupAttemptsCount() {
        guard (secureStorage.value(forKey: Keys.shakeAttempts.rawValue)) != nil else {
            secureStorage.set(0, forKey: Keys.shakeAttempts.rawValue)
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.attemptsCountRelay.accept(self.getAttemptsCount())
        }
    }

}
