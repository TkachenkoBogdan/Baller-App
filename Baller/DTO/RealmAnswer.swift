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
        case text, title, date, type, identifier
    }

    dynamic var text: String = ""
    dynamic var date: Date = Date.distantPast
    dynamic var type: String = ""
    dynamic var identifier = UUID().uuidString

    convenience init(title: String, date: Date = Date(), type: String = L10n.AnswerType.neutral) {
        self.init()

        self.text = title
        self.date = date
        self.type = type
    }

    override static func primaryKey() -> String? {
        return RealmAnswer.Property.identifier.rawValue
    }

}

extension RealmAnswer {

    func toAnswer() -> Answer {
        return Answer(title: text,
                      date: date,
                      type: AnswerType(rawValue: type) ?? AnswerType.neutral)
    }
}
