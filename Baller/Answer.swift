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

    init(withTitle title: String) {
        self.title = title
    }

}

extension Answer {

    func toPresentableAnswer() -> PresentableAnswer {
        return self.title.uppercased()
    }
}
