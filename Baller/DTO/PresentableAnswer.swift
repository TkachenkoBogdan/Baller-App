//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

struct PresentableAnswer {

    let text: String
    let formattedDate: String
    let type: AnswerType

    init(title: String, formattedDate: String, type: AnswerType) {
        self.text = title
        self.formattedDate = formattedDate
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
extension PresentableAnswer: Equatable {
}
