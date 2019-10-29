//
//  DependencyContainer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/28/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

// MARK: - Container:

final class DependencyContainer {

    private(set) lazy var answerService: AnswerProvider =
        AnswerService(onlineProvider: NetworkAnswerProvider(),
                      offlineProvider: DatabaseAnswerProvider(store: answerStore))

    private(set) lazy var answerStore: AnswerStore = RealmAnswerStore(realmProvider: .default)
    private(set) lazy var secureStorage: SecureStoring = SecureStorage()
}
