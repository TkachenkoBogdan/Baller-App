//
//  PresentableAnswer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

struct PresentableAnswer {

    let title: String

    var deletionHandler: ((_ index: Int) -> Void)?

    init(withTitle title: String) {
        self.title = title
    }

}
