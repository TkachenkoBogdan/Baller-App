//
//  PersistenceRepository.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

/// A common interface for objects that are able to act as a data source.

protocol AnswerStore {

    func answer(at index: Int) -> Answer?

    func appendAnswer(_ answer: Answer)
    func removeAnswer(at index: Int)

    func count() -> Int

}
