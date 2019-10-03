//
//  BallView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/1/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import SnapKit

class BallView: UIView {

    var ballImageView: UIImageView!
    var answerLabel: UILabel!
    var statusLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView!

    private var interactionIsInProcess: Bool = false {
        didSet {
            if interactionIsInProcess {
                setLabelsVisibility(to: false)
                activityIndicator.startAnimating()
                ballImageView.roll()
            } else {
                setLabelsVisibility(to: true)
                activityIndicator.stopAnimating()
                ballImageView.shake()
            }
        }
    }

    // MARK: - Initialization:

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 13.0, *) {
            backgroundColor = .tertiarySystemBackground
        } else {
            backgroundColor = .darkGray
        }

        createBallImageView()
        createAnswerLabel()
        createStatusLabel()
        createActivityIndicator()

    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Public:

    func startInteraction() {
        interactionIsInProcess = true
    }

    func stopInteraction() {
        interactionIsInProcess = false
    }

    func updateTextLabel(with text: String) {
        self.answerLabel?.text = text
    }

    // MARK: - Private:

    private func setLabelsVisibility(to visible: Bool) {

        UIView.animate(withDuration: 0.3, animations: {
            self.answerLabel?.alpha = visible ? 1 : 0
            self.statusLabel?.alpha = visible ? 1 : 0
        })

    }
}

// MARK: - Subview Creation:

extension BallView {

    private func createBallImageView() {
        ballImageView = UIImageView(image: Asset._8ball.image)
        self.addSubview(ballImageView)

        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseOut,
                       animations: { [unowned self] in
                        self.ballImageView?.snp.makeConstraints { maker in
                            maker.width.equalTo(self).multipliedBy(0.8)
                            maker.height.equalTo(self.ballImageView.snp.width)
                            maker.centerX.equalToSuperview()
                            maker.centerY.equalToSuperview().multipliedBy(0.7)
                        }
                        self.ballImageView.superview?.layoutIfNeeded()
        })

    }

    private func createAnswerLabel() {
        answerLabel = BallerLabel(fontSize: GlobalFont.Size.answerLabel)
        answerLabel.numberOfLines = 0
        answerLabel.textColor = .white

        ballImageView.addSubview(answerLabel)

        answerLabel?.snp.makeConstraints { maker in
            maker.center.equalTo(ballImageView)
            maker.height.equalTo(self).multipliedBy(0.3)
            maker.width.equalTo(self).multipliedBy(0.8)
        }
    }

    private func createStatusLabel() {
        statusLabel = BallerLabel(text: L10n.Labels.statusLabel, fontSize: GlobalFont.Size.statusLabel)
        self.addSubview(statusLabel)

        statusLabel?.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(1.5)
        }
    }

    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

        if #available(iOS 13.0, *) {
            activityIndicator.color = .secondaryLabel
        } else {
            activityIndicator.color = .white
        }

        self.addSubview(activityIndicator)

        activityIndicator?.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel.snp.bottom).inset(-activityIndicator.bounds.height / 2)
            maker.centerX.equalTo(self.snp.centerX)
        }
    }

}
