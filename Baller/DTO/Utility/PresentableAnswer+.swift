//
//  PresentableAnswer+IdentifiableType.swift
//  Baller
//
//  Created by Богдан Ткаченко on 27.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import RxDataSources

 // Animated changes with RxDataSources:
extension PresentableAnswer: IdentifiableType {
    public var identity: String {
        return text + formattedDate
    }
}
