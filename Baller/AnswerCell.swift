//
//  AnswerCell.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/20/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import Reusable

final class AnswerCell: UITableViewCell, Reusable {

    @IBOutlet private var answerLabel: UILabel?
    @IBOutlet private var dateLabel: UILabel?

    func configure(with answer: PresentableAnswer) {
        answerLabel?.text = answer.title
        dateLabel?.text = answer.dateAdded
    }
}
