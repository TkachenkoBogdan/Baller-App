//
//  ViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import SnapKit

final class BallViewController: UIViewController {

    var factory: AnswersListViewControllerFactory!
    var viewModel: BallViewModel!

    init(with viewModel: BallViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("BallViewController")
    }

    // MARK: - Outlets:

    private var ballImageView: UIImageView!
    private var answerLabel: UILabel!
    private var statusLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle and Events:

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObservationClosures()





        if #available(iOS 13.0, *) {
            view.backgroundColor = .tertiarySystemBackground
        } else {
            view.backgroundColor = .darkGray
        }

        makeBallView()
        makeAnswerLabel()
        makeStatusLabel()
        makeActivityIndicator()

    }

    private func makeBallView() {
        ballImageView = UIImageView(image: Asset._8ball.image)
        ballImageView.accessibilityIdentifier = "BallImageView"
        view.addSubview(ballImageView)
        ballImageView?.snp.makeConstraints { maker in
            maker.width.equalTo(view).multipliedBy(0.8)

            maker.height.equalTo(ballImageView.snp.width)
          //  maker.height.lessThanOrEqualTo(view).multipliedBy(0.5)

            maker.center.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0))
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

        statusLabel.font = FontFamily.Futura.condensedMedium.font(size: 32)
        view.addSubview(statusLabel)

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
        view.addSubview(activityIndicator)

        activityIndicator?.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel.snp.bottom).inset(-activityIndicator.bounds.height / 2)
            maker.centerX.equalTo(view.snp.centerX)
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }

        self.ballImageView?.shake()
        self.setLabelsVisibility(to: true)

        viewModel.shakeDetected()
    }

    @IBAction func optionsPressed(_ sender: Any) {
        let answersVC = factory.makeAnswersListController()
        show(answersVC, sender: nil)
    }

}

// MARK: - Private Helpers:

extension BallViewController {

    private func setUpObservationClosures() {

        viewModel.shouldAnimateLoadingStateHandler = { [unowned self] shouldAnimate in
            self.setAnimationEnabled(shouldAnimate)
        }

        viewModel.answerReceivedHandler = { [unowned self] answer in
            self.updateAnswerLabel(with: answer.title)
        }
    }

    private func setAnimationEnabled(_ enabled: Bool) {
        DispatchQueue.main.async {
            enabled ? self.activityIndicator?.startAnimating() : self.activityIndicator?.stopAnimating()
        }
    }

    private func updateAnswerLabel(with answer: String) {
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

    private func setLabelsVisibility(to isHidden: Bool) {
        self.answerLabel?.isHidden = isHidden
        self.statusLabel?.isHidden = isHidden
    }
}
