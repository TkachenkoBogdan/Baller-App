//
//  RealmDBManager.swift
//  Baller
//
//  Created by Богдан Ткаченко on 08.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RealmSwift

protocol AnswerStore {

    func answer(at index: Int) -> Answer?
    func appendAnswer(_ answer: Answer)
    func removeAnswer(at index: Int)

    func count() -> Int
}

class RealmDBManager {

    private let realmProvider: RealmProvider
    private var realm: Realm {
        return realmProvider.realm
    }

    private lazy var answers: Results<RealmAnswer> =
        realm.objects(RealmAnswer.self)
            .sorted(byKeyPath: RealmAnswer.Property.date.rawValue, ascending: false)

    init(realmProvider: RealmProvider) {
        self.realmProvider = realmProvider
    }

}

extension RealmDBManager: AnswerStore {

    func answer(at index: Int) -> Answer? {
        let answer = answers[index].toAnswer()
        return answer
    }

    func appendAnswer(_ answer: Answer) {
            try? self.realm.write {
                self.realm.add(answer.toRealmAnswer())
            }
    }

    func removeAnswer(at index: Int) {

        do {
            try realm.write {
                realm.delete(answers[index])
            }
        } catch {
            fatalError("Failed to delete the answer from the Realm!")
        }
    }

    func count() -> Int {
        return answers.count
    }
}
