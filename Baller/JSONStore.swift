//
//  JSONStore.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation

class JSONStore {
    
    private let answerFileName = "answers.json"
    
    public static let shared = JSONStore()
    
    private var answers = [Answer]() {
        didSet {
            save()
        }
    }

    private init() {
        if !Storage.fileExists(answerFileName, in: .documents) {
            self.answers = defaultAnswers()
            save()
        } else {
            self.answers = Storage.retrieve(answerFileName,
                                            from: .documents,
                                            as: [Answer].self) ?? [Answer]()
        }
    }
    
    private func save() {
        Storage.store(self.answers, to: .documents, as: answerFileName)
    }
    
    private func defaultAnswers () -> [Answer] {
        guard let answers = Storage.pathInBundle("DefaultAnswers.txt"),
            let answersData = try? Data(contentsOf: answers),
            let defaultAnswers = try? JSONDecoder().decode([Answer].self, from: answersData) else {
                return [Answer(withTitle: "Just do a moonwalk...")]
        }
        return defaultAnswers
    }
}

// MARK: - AnswerStore Protocol Conformance:
extension JSONStore: AnswerStore {
    
    func allAnswers() -> [Answer] {
        return answers
    }
    
    func answer(at index: Int) -> Answer? {
        if 0..<answers.count ~= index {
            return answers[index]
        }
        return nil
    }
    
    func answersCount() -> Int {
        return answers.count
    }
    
    func appendAnswer(_ answer: Answer) {
        self.answers.append(answer)
    }
    
    func removeAnswer(at index: Int) {
        if 0..<answers.count ~= index {
            answers.remove(at: index)
        }
    }
}
