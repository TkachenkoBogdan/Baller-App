//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

struct PresentableAnswer: Equatable {

    let text: String
    let formattedDate: String
    let identifier: String

    private let type: AnswerType

    // MARK: - Init:

    init(title: String, formattedDate: String, identifier: String, type: AnswerType) {
        self.text = title
        self.formattedDate = formattedDate
        self.identifier = identifier
        self.type = type
    }

    // MARK: - Public:

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
