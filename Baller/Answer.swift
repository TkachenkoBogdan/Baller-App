//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//


/// A simple model struct to represent answers.

struct Answer: Codable {
    
    enum CodingKeys: String, CodingKey {
        case containerDictionary  = "magic"
        case title = "answer"
    }
    
    let title: String
    
    init(withTitle title: String) {
        self.title = title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dictionary = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .containerDictionary)
        self.title = try dictionary.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dictionary = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .containerDictionary)
        try dictionary.encode(self.title, forKey: .title)
    }
}
