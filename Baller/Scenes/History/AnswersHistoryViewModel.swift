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

    let answersSection: PublishSubject<[AnswerSection]> = PublishSubject()
    let actions: PublishSubject<AnswerAction> = PublishSubject()

    // MARK: - Init:

    init(model: AnswersHistoryModel) {
        self.model = model

        setupBindings()
    }

    // MARK: - Private:

    private func setupBindings() {

        model.answers
            .map({ [weak self] answers -> [AnswerSection] in
                let answers = answers
                    .map {$0.toPresentableAnswer(withDateFormatter: self?.dateFormatter)}
                let sections = [AnswerSection(model: L10n.SectionHeader.history, items: answers)]
                return sections
            })
            .bind(to: self.answersSection)
            .disposed(by: disposeBag)

        actions
            .bind(to: model.actions)
            .disposed(by: disposeBag)
    }
}
