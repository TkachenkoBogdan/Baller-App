//
//  ViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import NSObject_Rx

final class BallViewController: ViewController<BallView> {

    private let viewModel: BallViewModel

    // MARK: - Initialization:

    init(viewModel: BallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Lifecycle:

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Events:

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        if !rootView.interactionIsInProgress {
            self.viewModel.shakeEvent.onNext(())
        }
    }

    // MARK: - RxBindings:

    private func setupBindings() {

        // UI Bindings:

        viewModel.answer
            .map { $0.text }
            .bind(to: rootView.answerLabel.rx.text)
            .disposed(by: rx.disposeBag)

        viewModel.isRequestInProgress
            .bind(to: rootView.rx.isInProgress)
            .disposed(by: rx.disposeBag)

        viewModel.attemptsCount
            .map(String.init)
            .bind(to: rootView.countLabel.rx.text)
            .disposed(by: rx.disposeBag)

        viewModel.answer
            .map { $0.semanticColor }
            .bind(to: rootView.rx.shadowColor)
            .disposed(by: rx.disposeBag)
    }
}
