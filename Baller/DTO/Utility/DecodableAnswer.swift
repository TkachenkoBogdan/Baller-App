//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

struct DecodableAnswer: Decodable {

    enum CodingKeys: String, CodingKey {
        case containerDictionary  = "magic"

        case text = "answer"
        case type
    }

    let text: String
    let type: AnswerType

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .containerDictionary)
        self.text = try dictionary.decode(String.self, forKey: .text)

        let typeString = try dictionary.decode(String.self, forKey: .type)
        type = AnswerType(rawValue: typeString)
    }
}

extension DecodableAnswer {

    func toAnswer() -> Answer {
        return Answer(title: text, type: type)
    }
}
