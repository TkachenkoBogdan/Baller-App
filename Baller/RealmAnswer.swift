//
//  RealmAnswer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/8/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RealmAnswer: Object {

    enum Property: String {
        case title, date, type, identifier
    }
    dynamic var title: String = ""
    dynamic var date: Date = Date.distantPast
    dynamic var type: String = ""
    dynamic var identifier = UUID().uuidString

    convenience init(title: String, date: Date = Date(), type: String = L10n.AnswerType.neutral) {
        self.init()

        self.title = title
        self.date = date
        self.type = type
    }

    override static func primaryKey() -> String? {
        return RealmAnswer.Property.identifier.rawValue
    }

}

//extension SerializableAnswer {
//    func toAnswer() -> Answer {
//        return Answer(title: title,
//                      date: dateReceived,
//                      type: AnswerType(rawValue: type) ?? AnswerType.neutral)
//    }
//}

extension RealmAnswer {

    static func add(answer: RealmAnswer) -> RealmAnswer? {
        guard let realm = try? Realm() else { return nil }

        try? realm.write {
            realm.add(answer)
        }
        return answer
    }

}
