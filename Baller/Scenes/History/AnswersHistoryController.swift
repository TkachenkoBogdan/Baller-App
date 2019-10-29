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
import NSObject_Rx
import RxDataSources

final class AnswersHistoryController: UITableViewController {

    private let viewModel: AnswersHistoryViewModel

    private var dataSource: RxTableViewSectionedAnimatedDataSource<AnswerSection>!
    private var sectionHasBeenBound = false

    // MARK: - Initialization:

    init(viewModel: AnswersHistoryViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Lifecycle:

    override func viewDidLoad() {
        setupNavigationItems()
        configureTableView()
        configureDataSource()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        bindAnswersSectionIfNeeded()
    }

    // MARK: - Private:

    private func configureDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<AnswerSection>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell: AnswerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: item)
                return cell
        }, titleForHeaderInSection: { dataSource, index in
            dataSource.sectionModels[index].model
        },
           canEditRowAtIndexPath: { _, _ in true })

        dataSource.animationConfiguration = AnimationConfiguration(
            insertAnimation: .right,
            reloadAnimation: .automatic,
            deleteAnimation: .fade)
    }

    private func bindAnswersSectionIfNeeded() {
        if !sectionHasBeenBound {
            viewModel.answersSection
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: rx.disposeBag)

            viewModel.actions.onNext(.triggerUpdate)
            sectionHasBeenBound = true
        }
    }

    private func setupNavigationItems() {

        //Delete all answers:
        let leftBarItem = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        leftBarItem.rx.tap
            .subscribe({ [weak self] _ in
                self?.presentConfirmationAlert(withTitle: L10n.Prompts.DeleteAll.title,
                                               message: L10n.Prompts.DeleteAll.message) {
                                                self?.viewModel.actions.onNext(.deleteAllAnswers)
                }
            })
            .disposed(by: rx.disposeBag)

        //Add a new answer:
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        rightBarItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.presentUserInputAlert(L10n.Prompts.newAnswer) { [weak self] (text) in
                    self?.viewModel.actions.onNext(.appendAnswer(title: text))
                }
            })
            .disposed(by: rx.disposeBag)

        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }

    private func configureTableView() {

        tableView.register(AnswerCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.allowsSelection = false
        self.tableView.dataSource = nil

        tableView.rx.itemDeleted
            .map { indexPath in
                return AnswerAction.deleteAnswer(index: indexPath.row)
        }
        .bind(to: viewModel.actions)
        .disposed(by: rx.disposeBag)
    }

}
