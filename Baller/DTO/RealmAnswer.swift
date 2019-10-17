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

    // MARK: - Properties:

    enum Property: String {
        case text, date, type, privateType, id // swiftlint:disable:this identifier_name
    }

    dynamic var text: String = ""
    dynamic var date: Date = Date()
    dynamic var id: String = UUID().uuidString // swiftlint:disable:this identifier_name

    var type: AnswerType {
        get { return AnswerType(rawValue: privateType) }
        set { privateType = newValue.rawValue }
    }

    @objc private dynamic var privateType: String = ""

    // MARK: - Init:

    convenience init(title: String, type: AnswerType) {
        self.init()

        self.text = title
        self.type = type
    }

    // MARK: - Overrides:

    override static func primaryKey() -> String? {
        return RealmAnswer.Property.id.rawValue
    }

}

extension RealmAnswer {

    func toAnswer() -> Answer {
        return Answer(title: text, date: date, type: type)
    }
}
