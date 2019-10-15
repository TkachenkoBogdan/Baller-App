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

    var answerListUpdateHandler: ((ChangeSet<Answer>) -> Void)? { get set }

    func appendAnswer(_ answer: Answer)
    func removeAnswer(at index: Int)

    func removeAllAnswers()
}

enum ChangeSet<T> {

     typealias ModelChange = (
            objects: [T]?,
            deletions: [Int],
            insertions: [Int],
            modifications: [Int]
        )

        case initial([T])
        case change(ModelChange)
        case error(Error)
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
    var answerListUpdateHandler: ((ChangeSet<Answer>) -> Void)?

    private var answersToken: NotificationToken?
    private lazy var internalQueue = DispatchQueue.global(qos: .userInitiated)

    // MARK: - Init:

    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
        setupObservationToken()
    }

    // MARK: - Private:

    private func setupObservationToken() {
        answersToken = answers.observe {  changes in

            if case .update(_, let deletions, let insertions, let updates) = changes {

                let changeSet = ChangeSet<Answer>.change((objects: nil,
                                                          deletions: deletions,
                                                          insertions: insertions,
                                                          modifications: updates))
                self.answerListUpdateHandler?(changeSet)
            }
        }
    }
}

extension RealmAnswerStore: AnswerStore {

    func answer(at index: Int) -> Answer? {
        let answer = answers[index].toAnswer()
        return answer
    }

    var count: Int {
        return answers.count
    }

    var isEmpty: Bool {
        return answers.isEmpty
    }

    func appendAnswer(_ answer: Answer) {
        internalQueue.async {
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