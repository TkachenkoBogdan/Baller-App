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
    //pure actions:
    case appendAnswer(title: String)
    case deleteAnswer(index: Int)
    case deleteAllAnswers

    //queries:
    case getCount
    case getAnswerAt(index: Int)
}

enum AnswerQueryResponse {
    case answerAt(Answer)
    case count(Int)
}

final class AnswersListViewModel {

    private let model: AnswerListModel

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()

    let vmAnswerQueryResponse: PublishSubject<AnswerQueryResponse> = PublishSubject()
    let vmChangesSubject: PublishSubject<ChangeSet<Answer>> = PublishSubject()
    let actionsSubject: PublishSubject<AnswerAction> = PublishSubject()

    private let disposeBag = DisposeBag()

    // MARK: - Init:

    init(model: AnswerListModel) {
        self.model = model
        setupRxBindings()
    }

    // MARK: - Public:

    func answer(at index: Int) -> PresentableAnswer? {
         return model.answer(at: index)?.toPresentableAnswer(withDateFormatter: dateFormatter)
     }

    func count() -> Int {
        return model.numberOfAnswers()
    }

    // MARK: - Private:

    private func setupRxBindings() {

        //Changes ----> VC:
        model.changeListSubject
            .bind(to: vmChangesSubject)
            .disposed(by: disposeBag)

        //Actions <--- VC:

        actionsSubject
            .bind(to: model.modelChangeActionSubject)
            .disposed(by: disposeBag)

        model.answerQueryResponse
            .bind(to: vmAnswerQueryResponse)
            .disposed(by: disposeBag)
    }
}
