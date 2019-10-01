//
//  BallView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/1/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class BallView: UIView {

    var ballImageView: UIImageView!
    var answerLabel: UILabel!
    var statusLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            backgroundColor = .tertiarySystemBackground
        } else {
            backgroundColor = .darkGray
        }

        makeBallView()
        makeAnswerLabel()
        makeStatusLabel()
        makeActivityIndicator()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAnimationEnabled(_ enabled: Bool) {
        DispatchQueue.main.async {
            enabled ? self.activityIndicator?.startAnimating() : self.activityIndicator?.stopAnimating()
        }
    }

    func updateAnswerLabel(with answer: String) {
        DispatchQueue.main.async {
            self.setLabelsVisibility(to: false)
            self.statusLabel?.alpha = 0
            self.answerLabel?.alpha = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                UIView.animate(withDuration: 1, animations: {
                    self.statusLabel?.alpha = 1
                    self.answerLabel?.alpha = 0
                })
            })
            self.answerLabel?.fadeTransition(withDuration: 1)
            self.answerLabel?.text = answer
        }

    }

    func setLabelsVisibility(to isHidden: Bool) {
        self.answerLabel?.isHidden = isHidden
        self.statusLabel?.isHidden = isHidden
    }
}

extension BallView {

    private func makeBallView() {
        ballImageView = UIImageView(image: Asset._8ball.image)
        ballImageView.accessibilityIdentifier = "BallImageView"
        self.addSubview(ballImageView)
        ballImageView?.snp.makeConstraints { maker in
            maker.width.equalTo(self).multipliedBy(0.2)
            maker.height.equalTo(ballImageView.snp.width)
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(0.1)
        }

        UIView.animate(withDuration: 0.4) {
            self.ballImageView?.snp.remakeConstraints({ (maker) in
                maker.width.equalTo(self).multipliedBy(0.8)
                maker.height.equalTo(self.ballImageView.snp.width)
                maker.centerX.equalToSuperview()
                maker.centerY.equalToSuperview().multipliedBy(0.7)
            })
            self.ballImageView.superview?.layoutIfNeeded()
        }
    }

    private func makeAnswerLabel() {
        answerLabel = UILabel()
        answerLabel.numberOfLines = 0
        answerLabel.textColor = .white

        answerLabel.font = FontFamily.Futura.condensedMedium.font(size: 28)
        ballImageView.addSubview(answerLabel)

        answerLabel?.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }

    private func makeStatusLabel() {
        statusLabel = UILabel()
        statusLabel.text = "Shake"

        if #available(iOS 13.0, *) {
            statusLabel.textColor = .label
        } else {
            statusLabel.textColor = .red
        }

        statusLabel.font = FontFamily.Futura.condensedMedium.font(size: Constants.statusLabelFontSize)
        self.addSubview(statusLabel)

        statusLabel?.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(1.5)
        }
    }

    private func makeActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        if #available(iOS 13.0, *) {
            activityIndicator.color = .secondaryLabel
        } else {
            activityIndicator.color = .black
        }
        self.addSubview(activityIndicator)

        activityIndicator?.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel.snp.bottom).inset(-activityIndicator.bounds.height / 2)
            maker.centerX.equalTo(self.snp.centerX)
        }
    }

}

enum Constants {

    static let statusLabelFontSize: CGFloat = 37

}
