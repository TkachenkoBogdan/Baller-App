//
//  PresentableAnswer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

enum AnswerType: String {
    case neutral = "Neutral"
    case affirmative = "Affirmative"
    case contrary = "Contrary"
}

struct Answer {

    let title: String
    let date: Date
    let type: AnswerType

    init(title: String, date: Date = Date(), type: AnswerType = .neutral) {
        self.title = title
        self.date = date
        self.type = type
    }

}

extension Answer {

    func toPresentableAnswer(withDateFormatter dateFormatter: DateFormatter? = nil,
                             uppercased: Bool = false) -> PresentableAnswer {

        let title =  uppercased ? self.title.uppercased() : self.title
        let date = dateFormatter?.string(from: self.date) ?? ""
        return PresentableAnswer(title: title, date: date, type: type)
    }

    func toPersistableAnswer() -> SerializableAnswer {
        return SerializableAnswer(title: title, date: date)
    }
}
