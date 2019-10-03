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

    private var factory: AnswersListViewControllerFactory
    private var viewModel: BallViewModel

    private lazy var ballView: BallView = BallView()

    init(viewModel: BallViewModel, factory: AnswersListViewControllerFactory ) {
        self.viewModel = viewModel
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Lifecycle:

    override func loadView() {
        self.view = ballView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpObservationClosures()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.defaultAnswers.image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(optionsPressed(_:)))
    }

    // MARK: - Events:

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }

        ballView.ballImageView?.shake()
        ballView.setLabelsVisibility(to: true)

        viewModel.shakeDetected()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    @IBAction func optionsPressed(_ sender: Any) {
        let answersVC = factory.makeAnswersListController()
        show(answersVC, sender: nil)
    }

}

// MARK: - Helpers:

extension BallViewController {

    private func setUpObservationClosures() {

        viewModel.shouldAnimateLoadingStateHandler = { [unowned self] shouldAnimate in
            self.ballView.setAnimationEnabled(shouldAnimate)
        }

        viewModel.answerReceivedHandler = { [unowned self] answer in
            self.ballView.updateAnswerLabel(with: answer.title)
        }
    }

}
