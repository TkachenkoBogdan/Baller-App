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

import RxDataSources

final class AnswersListController: UITableViewController {

    private let viewModel: AnswersListViewModel

    private var dataSource: RxTableViewSectionedAnimatedDataSource<SectionOfPresentableAnswer>!
    private let disposeBag = DisposeBag()

    // MARK: - Initialization:

    init(viewModel: AnswersListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)

        //setupRxBindings()
        configureDataSource()
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Lifecycle:

    override func viewDidLoad() {
        setupNavigationItems()
        configureTableView()
    }

    // MARK: - Private:

    // RxBindings:

//    private func setupRxBindings() {
//
//    }

    private func setupNavigationItems() {
        navigationItem.title = L10n.Titles.answerList

        let leftBarItem = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        leftBarItem.rx.tap
            .subscribe({ [weak self] _ in
                self?.presentConfirmationAlert(withTitle: L10n.Prompts.DeleteAll.title,
                                         message: L10n.Prompts.DeleteAll.message) {
                                            self?.viewModel.actionsSubject.onNext(.deleteAllAnswers)
                }
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

        tableView.rx.itemDeleted
            .subscribe(onNext: { indexPath in
                self.viewModel.actionsSubject.onNext(.deleteAnswer(index: indexPath.row))
        })
        .disposed(by: disposeBag)
    }

    private func configureDataSource() {

        self.tableView.dataSource = nil
        self.tableView.delegate = nil

        dataSource = RxTableViewSectionedAnimatedDataSource<SectionOfPresentableAnswer>(
            configureCell: { dataSource, tableView, indexPath, item in
                let cell: AnswerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configure(with: item)
                return cell
        }, titleForHeaderInSection: { dataSource, index in
            dataSource.sectionModels[index].header
        },
           canEditRowAtIndexPath: { _, _ in true })

        viewModel.vmAnswersSubject
            .asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

struct SectionOfPresentableAnswer {
     var header: String
     var items: [Item]
   }

extension SectionOfPresentableAnswer: AnimatableSectionModelType {

  typealias Item = PresentableAnswer

    var identity: String {
        return header
    }

   init(original: SectionOfPresentableAnswer, items: [Item]) {
    self = original
    self.items = items
  }

}
extension PresentableAnswer: IdentifiableType {
    public var identity: String {
        return UUID().uuidString
    }
}
