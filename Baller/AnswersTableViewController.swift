//
//  AnswersTableViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class AnswersTableViewController: UITableViewController {
    
    let store: AnswerStore = JSONStore.shared

    @IBAction func addButtonPressed(_ sender: Any) {
        presentUserInputAlert("Please provide your answer") { [weak self] (answer) in
            guard let `self` = self else { return }
            self.store.appendAnswer(Answer(withTitle: answer))
            self.tableView.reloadData()
        }
    }
}

extension AnswersTableViewController {
    // MARK: - TableView DataSource:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.answersCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let answer = store.answer(at: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell",
                                                    for: indexPath) as? AnswerCell else {
            return UITableViewCell()
        }
            cell.answer = answer.title
        return cell
    }
    
    // MARK: - TablewViewDelegate:
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            store.removeAnswer(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
