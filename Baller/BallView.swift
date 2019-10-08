//
//  BallView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/1/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import SnapKit

final class BallView: UIView {

    // MARK: - Properties:

    private var eightBall: BallImageView!
    private var answerLabel: UILabel!
    private var statusLabel: UILabel!

    private var activityIndicator: UIActivityIndicatorView!
    private var countLabel: UILabel!
    private var ballHasRolledToScreen = false

    private var interactionIsInProcess: Bool = false {

        didSet {
            if interactionIsInProcess {
                setLabelsVisibility(to: false)
                activityIndicator.startAnimating()
                eightBall.roll()
            } else {
                setLabelsVisibility(to: true)
                activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Initialization:

    override init(frame: CGRect) {
        super.init(frame: frame)

        setDarkSemanticBackground()

        createBallImageView()
        createAnswerLabel()
        createStatusLabel()
        createActivityIndicator()
        createCountLabel()
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
        answerLabel?.text = text
    }

    func updateShadow(with color: UIColor) {
        eightBall.updateShadowColor(with: color)
    }

    func updateCountLabel(with count: Int) {
        countLabel.pushTransition(0.3)
        countLabel.text = String(count)
    }

    override func didMoveToWindow() {
        if !ballHasRolledToScreen {
            eightBall.rollToScreen()
            ballHasRolledToScreen = true
        } else if window != nil {
            eightBall.appearWithAnimation()
        }
    }
    // MARK: - Private:

    private func setLabelsVisibility(to visible: Bool) {

        UIView.animate(withDuration: 0.3, animations: {
            self.answerLabel?.alpha = visible ? 1 : 0
            self.statusLabel?.alpha = visible ? 1 : 0
        })
    }

    private func setDarkSemanticBackground() {
        if #available(iOS 13.0, *) {
            backgroundColor = .tertiarySystemBackground
        } else {
            backgroundColor = .darkGray
        }
    }

}

// MARK: - Subviews Creation and Layout:

extension BallView {

    private func createBallImageView() {

        eightBall = BallImageView(image: Asset._8ball.image)

        self.addSubview(eightBall)

        self.eightBall?.snp.makeConstraints { maker in
            maker.width.equalTo(self).multipliedBy(0.8)
            maker.height.equalTo(self.eightBall.snp.width)
            maker.centerX.equalToSuperview()
            maker.top.lessThanOrEqualTo(safeAreaLayoutGuide.snp.top).inset(50)
        }
    }

    private func createAnswerLabel() {
        answerLabel = BallerLabel(fontSize: AppFont.Size.answerLabel)
        answerLabel.textColor = .white

        eightBall.addSubview(answerLabel)

        answerLabel?.snp.makeConstraints { maker in
            maker.center.equalTo(eightBall)
            maker.height.equalTo(self).multipliedBy(0.3)
            maker.width.equalTo(self).multipliedBy(0.8)
        }
    }

    private func createStatusLabel() {
        statusLabel = BallerLabel(text: L10n.Labels.statusLabel, fontSize: AppFont.Size.statusLabel)

        self.addSubview(statusLabel)

        statusLabel?.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalTo(eightBall.snp.bottom).inset(-60)
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
            maker.center.equalTo(statusLabel.snp.center)
        }
    }

    private func createCountLabel() {
        countLabel = BallerLabel(text: "",
                                 numberOfLines: 1,
                                 fontSize: AppFont.Size.statusLabel)
           self.addSubview(countLabel)

           countLabel?.snp.makeConstraints { maker in
               maker.centerX.equalToSuperview()
            maker.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(25)
           }
       }

}
