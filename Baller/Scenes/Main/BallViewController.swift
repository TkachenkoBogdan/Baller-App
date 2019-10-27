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

final class BallViewController: UIViewController {

    private let viewModel: BallViewModel
    private lazy var ballView: BallView = BallView()

    private let shakeEventTrigger: PublishSubject<Void> = PublishSubject()

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

    override func loadView() {
        self.view = ballView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Events:

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        if !ballView.interactionIsInProcess {
            self.viewModel.shakeEventTriggered.onNext(())
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - RxBindings:

    private func setupBindings () {

        // Request in progress:

        viewModel.isRequestInProgress
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { requestIsInProgress in
                self.ballView.interactionIsInProcess = requestIsInProgress
            })
            .disposed(by: rx.disposeBag)

        // MARK: - UI Bindings:

        viewModel.attemptsCount
            .map(String.init)
            .bind(to: ballView.countLabel.rx.text)
            .disposed(by: rx.disposeBag)

        viewModel.answer
            .map { $0.text }
            .bind(to: ballView.answerLabel.rx.text)
            .disposed(by: rx.disposeBag)

        viewModel.answer
            .map { $0.semanticColor }
            .bind(to: ballView.rx.shadowColor)
            .disposed(by: rx.disposeBag)
    }
}
