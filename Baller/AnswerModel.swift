//
//  ActiveModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class AnswerModel {

    // upper layer (view model) may observe `isLoadingData` changes using closure
       var isLoadingDataStateHandler: ((Bool) -> Void)?

       // model stores "state", it knows if data is loading right now
       private var isLoadingData = false {
           didSet {
               isLoadingDataStateHandler?(isLoadingData)
           }
       }

       private func loadData() {
           isLoadingData = true
           /*
           .... data loading logic
           */
           isLoadingData = false
       }
}
