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

final class BallViewController: UIViewController {

    private let viewModel: BallViewModel
    private lazy var ballView: BallView = BallView()

    private let shakeEventTrigger: PublishSubject<Void> = PublishSubject()
    private let disposeBag = DisposeBag()

    // MARK: - Initialization:

    init(viewModel: BallViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        setupRxBindings()
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
        shakeEventTrigger.onNext(())
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - RxBindings:

    private func setupRxBindings () {
        // Shake event:
        self.shakeEventTrigger
            .bind(to: viewModel.shakeEventTriggered)
            .disposed(by: disposeBag)

        // Request in progress:
        viewModel.vmRequestInProgressSubject
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { requestIsInProgress in
                self.ballView.interactionIsInProcess = requestIsInProgress
            })
            .disposed(by: disposeBag)

        // MARK: - UI Bindings:

        viewModel.vmAttemptsCount
            .map(String.init)
            .bind(to: ballView.countLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.vmAnswerSubject
            .map { $0.text }
            .bind(to: ballView.answerLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.vmAnswerSubject
            .map { $0.semanticColor }
            .bind(to: ballView.rx.shadowColor)
            .disposed(by: disposeBag)
    }
}
