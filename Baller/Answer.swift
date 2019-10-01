//
//  PresentableAnswer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

struct Answer {

    let title: String
    let date: Date

    init(title: String, date: Date = Date()) {
        self.title = title
        self.date = date
    }

}

extension Answer {

    func toPresentableAnswer(withDateFormatter dateFormatter: DateFormatter? = nil,
                             uppercased: Bool = false) -> PresentableAnswer {

        let title =  uppercased ? self.title.uppercased() : self.title
        let date = dateFormatter?.string(from: self.date) ?? ""

        return PresentableAnswer(title: title, date: date)
    }

    func toPersistableAnswer() -> SerializableAnswer {
        return SerializableAnswer(title: title, date: date)
    }
}
