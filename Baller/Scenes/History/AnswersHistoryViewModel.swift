//
//  AnswersViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import NSObject_Rx

typealias AnswerSection = AnimatableSectionModel<String, PresentableAnswer>

final class AnswersHistoryViewModel: HasDisposeBag {

    private let model: AnswersHistoryModel

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM d HH:mm:ss")
        return formatter
    }()

    let actions: PublishSubject<AnswerAction> = PublishSubject()
    let answerSection: PublishSubject<[AnswerSection]> = PublishSubject()

    // MARK: - Init:

    init(model: AnswersHistoryModel) {
        self.model = model

        setupBindings()
    }

    // MARK: - Private:

    private func setupBindings() {

        model.answerSubject
        .map({ [weak self] answers -> [AnswerSection] in
            let answers = answers.map {$0.toPresentableAnswer(withDateFormatter: self?.dateFormatter,
                                                              uppercased: true)}
            let sections = [AnswerSection(model: "History", items: answers)]
            return sections
        })
        .bind(to: self.answerSection)
            .disposed(by: disposeBag)

        actions
            .bind(to: model.modelChangeActionSubject)
            .disposed(by: disposeBag)
    }
}
