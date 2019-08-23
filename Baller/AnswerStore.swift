//
//  PersistenceRepository.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

 protocol AnswerStore {
    func allAnswers() -> [Answer]
    func appendAnswer(_ answer: Answer)
    func removeAnswer(at index: Int)
    func answersCount() -> Int
    func answer(at index: Int) -> Answer?
}
