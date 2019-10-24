//
//  AnswersViewModel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 9/27/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import Foundation
import RxSwift

enum AnswerAction {

    case appendAnswer(title: String)
    case deleteAnswer(index: Int)
    case deleteAllAnswers
}

final class AnswersListViewModel {

    private let model: AnswerListModel

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    let vmChangesSubject: PublishSubject<ChangeSet<Answer>> = PublishSubject()
    let actionsSubject: PublishSubject<AnswerAction> = PublishSubject()

    let vmAnswersSubject: PublishSubject<[SectionOfPresentableAnswer]> = PublishSubject()

    private let disposeBag = DisposeBag()

    // MARK: - Init:

    init(model: AnswerListModel) {
        self.model = model
        setupRxBindings()
    }

    // MARK: - Public:

    // MARK: - Private:

    private func setupRxBindings() {

        // Answers -->
        model.answerSubject
        .map({ answers -> [SectionOfPresentableAnswer] in
            let answers = answers.map {$0.toPresentableAnswer(withDateFormatter: nil, uppercased: true)}
            let sections = [SectionOfPresentableAnswer(header: "History", items: answers)]
            return sections
        })
        .bind(to: self.vmAnswersSubject)
        .disposed(by: disposeBag)

        //Changes ----> VC:
        model.changeListSubject
            .bind(to: vmChangesSubject)
            .disposed(by: disposeBag)

        //Actions <--- VC:

        actionsSubject
            .bind(to: model.modelChangeActionSubject)
            .disposed(by: disposeBag)
    }
}
