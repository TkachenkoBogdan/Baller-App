//
//  AnswersTableViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AnswersListController: UITableViewController {

    private let viewModel: AnswersListViewModel

    private let vcChangeActionSubject: PublishSubject<AnswerAction> = PublishSubject()
    private let disposeBag = DisposeBag()

    // MARK: - Initialization:

    init(viewModel: AnswersListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)

        setupRxBindings()
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - RxBindings:

    private func setupRxBindings() {

        //Delete all answers:

        vcChangeActionSubject
            .bind(to: viewModel.actionsSubject)
            .disposed(by: disposeBag)

        //Changes:
        viewModel.vmChangesSubject
            .subscribe(onNext: { changeSet in
                if case .change(_, let deletions, let insertions, let updates) = changeSet {
                    self.tableView.applyChanges(deletions: deletions,
                                                            insertions: insertions,
                                                            updates: updates)
                            }
            })
            .disposed(by: disposeBag )

    }

    // MARK: - Lifecycle:

    override func viewDidLoad() {
        setupNavigationItems()
        configureTableView()
    }

    // MARK: - Private:

    private func setupNavigationItems() {
        navigationItem.title = L10n.Titles.answerList

        let leftBarItem = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        leftBarItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.actionsSubject.onNext(.deleteAllAnswers)
            })
            .disposed(by: disposeBag)

        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        rightBarItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.presentUserInputAlert(L10n.Prompts.newAnswer) { [weak self] (text) in
                    self?.viewModel.actionsSubject.onNext(.appendAnswer(title: text))
                }
            })
            .disposed(by: disposeBag)

        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }

    private func configureTableView() {
        tableView.register(AnswerCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = false
    }
}

extension AnswersListController {

    // MARK: - TableView DataSource:

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: AnswerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        guard let answer = self.viewModel.answer(at: indexPath.row) else { return cell }
        cell.configure(with: answer)

        return cell
    }

    // MARK: - TablewViewDelegate:

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            viewModel.actionsSubject.onNext(.deleteAnswer(index: indexPath.row))
        }
    }
}
