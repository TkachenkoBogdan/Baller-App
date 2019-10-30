//
//  RealmDBManager.swift
//  Baller
//
//  Created by Богдан Ткаченко on 08.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RealmSwift

protocol AnswerStore: AnyObject {

    func answer(at index: Int) -> Answer?

    var count: Int { get }
    var isEmpty: Bool { get }

    func provideUpdates()
    var answersDidUpdateHandler: (([Answer]) -> Void)? { get set }

    func appendAnswer(_ answer: Answer)
    func removeAnswer(at index: Int)

    func removeAllAnswers()
}

class RealmAnswerStore {

    // MARK: - Properties:

    private let realmProvider: RealmProvider
    private var realm: Realm {
        return realmProvider.realm
    }

    private lazy var answers: Results<RealmAnswer> = realm.objects(RealmAnswer.self)
        .sorted(byKeyPath: RealmAnswer.Property.date.rawValue,
                ascending: false)

    var answersDidUpdateHandler: (([Answer]) -> Void)?

    private var observationToken: NotificationToken?
    private lazy var internalQueue = DispatchQueue(label: "com.baller.privateQueue",
                                                   qos: .userInitiated,
                                                   attributes: .concurrent)

    // MARK: - Init:

    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
        setupObservationToken()
    }

    // MARK: - Private:

    private func setupObservationToken() {
        observationToken = answers.observe { [unowned self]  _ in
            self.propagateUpdates()
        }
    }

    private func propagateUpdates() {
        self.answersDidUpdateHandler?(self.allAnswers())
    }

    private func allAnswers() -> [Answer] {
        return answers.map {$0.toAnswer()}
    }
}

// MARK: - Answer Store:

extension RealmAnswerStore: AnswerStore {

    func answer(at index: Int) -> Answer? {
        let answer = answers[index].toAnswer()
        return answer
    }

    func provideUpdates() {
        propagateUpdates()
    }

    var count: Int {
        return answers.count
    }

    var isEmpty: Bool {
        return answers.isEmpty
    }

    func appendAnswer(_ answer: Answer) {
        internalQueue.sync {
            do {
                try self.realm.write {
                    self.realm.add(answer.toRealmAnswer())
                }
            } catch {
                fatalError(L10n.FatalErrors.Realm.failedToAddAnswer)
            }
        }
    }

    func removeAnswer(at index: Int) {
        do {
            try realm.write {
                realm.delete(answers[index])
            }
        } catch {
            fatalError(L10n.FatalErrors.Realm.failedToDeleteAnswer)
        }
    }

    func removeAllAnswers() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            fatalError(L10n.FatalErrors.Realm.failedToDeleteAllAnswers)
        }
    }
}
