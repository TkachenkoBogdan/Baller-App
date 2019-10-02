//
//  AnswerCell.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/20/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

final class AnswerCell: UITableViewCell {

    private var answerLabel: UILabel = {
        let answerLabel = UILabel()
        answerLabel.numberOfLines = 0

        if #available(iOS 13.0, *) {
            answerLabel.textColor = .label
        } else {
            answerLabel.textColor = .red
        }
        answerLabel.font = FontFamily.Futura.condensedMedium.font(size: 17)
        return answerLabel
    }()

    private var dateLabel: UILabel = {
        let dateLabel = UILabel()

        dateLabel.numberOfLines = 0
        if #available(iOS 13.0, *) {
            dateLabel.textColor = .label
        } else {
            dateLabel.textColor = .red
        }
        dateLabel.font = FontFamily.Futura.condensedMedium.font(size: 12)
        return dateLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(answerLabel)
        answerLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(20)
        }

        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { maker in
            maker.top.equalTo(answerLabel.snp.bottom).inset(10)
            maker.trailing.equalToSuperview().inset(10)
            maker.bottom.equalToSuperview().inset(10)
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with answer: PresentableAnswer) {
        answerLabel.text = answer.title
        dateLabel.text = answer.dateAdded
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.answerLabel.text = ""
        self.dateLabel.text = ""
    }

}
