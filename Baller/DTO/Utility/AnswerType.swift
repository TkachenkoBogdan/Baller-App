//
//  AnswerType.swift
//  Baller
//
//  Created by Богдан Ткаченко on 17.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

enum AnswerType: String {
    case neutral = "Neutral"
    case affirmative = "Affirmative"
    case contrary = "Contrary"

    init(rawValue: String) {
        switch rawValue {
        case "Neutral": self = .neutral
        case "Affirmative": self = .affirmative
        case "Contrary": self = .contrary
        default: self = .neutral
        }
    }
}
