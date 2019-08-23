//
//  AnswerProvider.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

protocol AnswerProviding {
    func getAnswer(completionHandler: @escaping (Result<Answer, Error>) -> Void)
}
