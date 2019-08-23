//
//  AnswerCell.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/20/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {
    @IBOutlet private var answerLabel: UILabel?
    
    var answer: String? {
        didSet {
            self.answerLabel?.text = answer
        }
    }
}
