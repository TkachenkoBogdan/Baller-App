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

enum AnswerAction {

    case appendAnswer(title: String)
    case deleteAnswer(index: Int)
    case deleteAllAnswers
}

typealias AnswerSection = AnimatableSectionModel<String, PresentableAnswer>

final class AnswersListViewModel: HasDisposeBag {

    private let model: AnswerListModel

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM d HH:mm:ss")
        return formatter
    }()

    let actionsSubject: PublishSubject<AnswerAction> = PublishSubject()
    let vmAnswersSubject: PublishSubject<[AnswerSection]> = PublishSubject()

    // MARK: - Init:

    init(model: AnswerListModel) {
        self.model = model
        setupBindings()
    }

    // MARK: - Private:

    private func setupBindings() {

        model.answerSubject
        .map({ answers -> [AnswerSection] in
            let answers = answers.map {$0.toPresentableAnswer(withDateFormatter: self.dateFormatter, uppercased: true)}
            let sections = [AnswerSection(model: "History", items: answers)]
            return sections
        })
        .bind(to: self.vmAnswersSubject)
            .disposed(by: disposeBag)

        actionsSubject
            .bind(to: model.modelChangeActionSubject)
            .disposed(by: disposeBag)
    }
}
