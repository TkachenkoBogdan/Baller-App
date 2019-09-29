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

    init(withTitle title: String, date: Date) {
        self.title = title
        self.date = date
    }

}

extension Answer {

    func toPresentableAnswer() -> PresentableAnswer {
        let title = self.title.uppercased()
        let date = self.date.toString(withStyle: .long)

        return PresentableAnswer(withTitle: title, date: date)
    }
}
