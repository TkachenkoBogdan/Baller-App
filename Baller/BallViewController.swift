//
//  ViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import Reusable

class BallViewController: UIViewController {

    var factory: AnswersListViewControllerFactory!
    var viewModel: BallViewModel!

    // MARK: - Outlets:

    @IBOutlet private var ballImageView: UIImageView?
    @IBOutlet private var answerLabel: UILabel?
    @IBOutlet private var statusLabel: UILabel?
    @IBOutlet private var activityIndicator: UIActivityIndicatorView?

    // MARK: - Lifecycle and events:

    override func viewDidLoad() {
        super.viewDidLoad()

        // Observation closures:
        viewModel.shouldAnimateLoadingStateHandler = { [unowned self] shouldAnimate in
            self.setAnimationEnabled(shouldAnimate)
        }

        viewModel.answerReceivedHandler = { [unowned self] answer in
            self.updateAnswerLabel(with: answer)
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

      private func setAnimationEnabled(_ enabled: Bool) {
        DispatchQueue.main.async {
            enabled ? self.activityIndicator?.startAnimating() : self.activityIndicator?.stopAnimating()
        }

      }
    @IBAction func optionsPressed(_ sender: Any) {
        let answersVC = factory.makeAnswersListController()
        show(answersVC, sender: nil)
    }

}

// MARK: - Helpers:
extension BallViewController {

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
