//
//  Answer.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension UITableView {

    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        if self.window != nil {
            beginUpdates()
            deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
            insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
            reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
            endUpdates()
        } else {
            reloadData()
        }
    }
}

extension IndexPath {

  static func fromRow(_ row: Int) -> IndexPath {
    return IndexPath(row: row, section: 0)
  }
}
