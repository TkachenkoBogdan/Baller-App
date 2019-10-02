//
//  AnswersTableViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

final class AnswersListController: UITableViewController {

    var viewModel: AnswersListViewModel

    init(viewModel: AnswersListViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)

        navigationItem.prompt = L10n.Prompts.additionInfo
        navigationItem.title = L10n.Titles.answerList
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addButtonPressed(_:)))
    }

    required init?(coder: NSCoder) {
        fatalError("AnswersListController must not be initialized from xib/storyboard")
    }

    override func viewDidLoad() {
        tableView.register(AnswerCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.allowsSelection = false

    }

    @IBAction private func addButtonPressed(_ sender: Any) {

        presentUserInputAlert(L10n.Prompts.newAnswer) { [weak self] (answerString) in
            guard let `self` = self else { return }

            self.viewModel.appendAnswer(withTitle: answerString)

            self.tableView.reloadData()
        }

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
            viewModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
