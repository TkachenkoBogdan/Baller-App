//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

struct PresentableAnswer {

    let title: String
    let dateAdded: String
    let type: AnswerType

    init(title: String, date: String, type: AnswerType) {
        self.title = title
        self.dateAdded = date
        self.type = type
    }

    var semanticColor: UIColor {

        switch type {
        case .affirmative:
            return .green
        case .contrary:
            return .red
        case .neutral:
            return .black
        }
    }

}
