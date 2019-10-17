//
//  PresentableAnswer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

struct Answer {

    let text: String
    let date: Date
    let type: AnswerType

    init(title: String, date: Date = Date(), type: AnswerType = .neutral) {
        self.text = title
        self.date = date
        self.type = type
    }
}

extension Answer {

    func toRealmAnswer() -> RealmAnswer {
        return RealmAnswer(title: text, type: type)
    }

    func toPresentableAnswer(withDateFormatter dateFormatter: DateFormatter? = nil,
                             uppercased: Bool = false) -> PresentableAnswer {

        let title =  uppercased ? self.text.uppercased() : self.text
        let formattedDate = dateFormatter?.string(from: self.date) ?? ""
        return PresentableAnswer(title: title, formattedDate: formattedDate, type: type)
    }
}
