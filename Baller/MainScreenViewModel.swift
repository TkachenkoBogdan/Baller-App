//
//  MainViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class MainScreenViewModel {

    init(answerProvider provider: AnswerProviding) {
        self.answerProvider = provider
    }

    let answerProvider: AnswerProviding

}
