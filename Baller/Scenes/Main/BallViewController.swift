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

    private var viewModel: BallViewModel

    private lazy var ballView: BallView = BallView()

    // MARK: - Initialization:

    init(viewModel: BallViewModel) {
        self.viewModel = viewModel
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
    }

    // MARK: - Events:

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        viewModel.shakeDetected()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

}

// MARK: - Private:

extension BallViewController {

    private func setUpObservationClosures() {

        viewModel.requestInProgressHandler = { [unowned self] isInProgress in
            if isInProgress {
                DispatchQueue.main.async {
                    self.ballView.startInteraction()
                }
            }
        }

        viewModel.countUpdatedHandler = { count in
            DispatchQueue.main.async {
                self.ballView.updateCountLabel(with: count)
            }
        }

        viewModel.answerReceivedHandler = { [unowned self] answer in

            DispatchQueue.main.async {
                self.ballView.updateTextLabel(with: answer.title)
                self.ballView.updateShadow(with: answer.semanticColor)
                self.ballView.stopInteraction()
            }

        }
    }

}
