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

    private let vcAnswerSubject: PublishSubject<PresentableAnswer> = PublishSubject()
    private let attemptsCountSubject: PublishSubject<Int> = PublishSubject()
    private let requestInProgressSubject: PublishSubject<Bool> = PublishSubject()
    private let triggerShakeEvent: PublishSubject<Void> = PublishSubject()

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
        triggerShakeEvent.onNext(())
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - RxBindings:

    private func setupRxBindings () {

        //Getting an answer:

        viewModel.vmAnswerSubject
            .bind(to: vcAnswerSubject)
            .disposed(by: disposeBag)

        vcAnswerSubject
            .subscribe(onNext: { answer in
                DispatchQueue.main.async {
                    self.ballView.updateTextLabel(with: answer.text)
                    self.ballView.updateShadow(with: answer.semanticColor)
                    self.ballView.stopInteraction()
                }
            })
            .disposed(by: disposeBag)

        // Shake event:

        self.triggerShakeEvent
            .bind(to: viewModel.shakeEventTriggered)
            .disposed(by: disposeBag)

        // Attempts count:

        viewModel.vmAttemptsCount
            .bind(to: attemptsCountSubject)
            .disposed(by: disposeBag)

        attemptsCountSubject
            .subscribe(onNext: { count in
                self.ballView.updateCountLabel(with: count)
            })
            .disposed(by: disposeBag)

        // Request in progreess:

        viewModel.vmRequestInProgressSubject
            .bind(to: requestInProgressSubject)
            .disposed(by: disposeBag)

        requestInProgressSubject
            .subscribe(onNext: { isInProgress in
                if isInProgress {
                    DispatchQueue.main.async {
                        self.ballView.startInteraction()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
