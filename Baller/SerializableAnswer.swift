//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

struct SerializableAnswer: Codable {

    enum CodingKeys: String, CodingKey {
        case containerDictionary  = "magic"
        case title = "answer"
        case dateReceived
    }

    let title: String
    let dateReceived: Date

    init(title: String, date: Date = Date()) {
        self.title = title
        self.dateReceived = date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .containerDictionary)
        self.title = try dictionary.decode(String.self, forKey: .title)
        self.dateReceived = (try? dictionary.decode(Date.self, forKey: .dateReceived)) ?? Date()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dictionary = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .containerDictionary)
        try dictionary.encode(self.title, forKey: .title)
        try dictionary.encode(self.dateReceived, forKey: .dateReceived)
    }
}

extension SerializableAnswer {
    func toAnswer() -> Answer {
        return Answer(title: title, date: dateReceived)
    }
}
