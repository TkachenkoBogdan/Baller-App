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
        let answerLabel = BallerLabel(fontSize: AppFont.Size.cellAnswerLabel)
        answerLabel.textAlignment = .left
        return answerLabel
    }()

    private var dateLabel: UILabel = {
        return BallerLabel(fontSize: AppFont.Size.cellDateLabel)
    }()

    // MARK: - Initialization:

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
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

    // MARK: - Private:

    private func setUpSubviews() {
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
}
