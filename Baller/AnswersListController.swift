//
//  AnswersTableViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import SnapKit

final class AnswersListController: UITableViewController {

    var viewModel: AnswersListViewModel!

    @IBAction private func addButtonPressed(_ sender: Any) {

        presentUserInputAlert("Provide an answer") { [weak self] (answerString) in
            guard let `self` = self else { return }

            self.viewModel.answerAppended(withTitle: answerString)

            self.tableView.reloadData()
        }

    }

}

extension AnswersListController {

    // MARK: - TableView DataSource:

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: AnswerCell = tableView.dequeueReusableCell(for: indexPath)
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
            viewModel.answerDeleted(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
