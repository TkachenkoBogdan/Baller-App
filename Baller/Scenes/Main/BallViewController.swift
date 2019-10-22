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

    private var viewModel: BallViewModel
    private lazy var ballView: BallView = BallView()

    private let vcAnswerSubject: PublishSubject<PresentableAnswer> = PublishSubject()
    private let attemptsCount: PublishSubject<Int> = PublishSubject()
    private let requestInProgressSubject: PublishSubject<Bool> = PublishSubject()
    private let triggerShakeEvent: PublishSubject<Void> = PublishSubject()

    //private var attemptsCountSub: Disposable
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

   // MARK: - RxBindings:

    private func setupRxBindings () {
        // Shake event:

        self.triggerShakeEvent
            .bind(to: viewModel.vmTriggerShakeEvent)
            .disposed(by: disposeBag)

        triggerShakeEvent
            .asObservable()
            .subscribe(onNext: {
                print("Shake detected in ViewController")
            })
            .disposed(by: disposeBag)

        // Attempts count:

        viewModel.vmAttemptsCount
                   .bind(to: attemptsCount)
                   .disposed(by: disposeBag)

        attemptsCount
            .asObservable()
            .subscribe(onNext: { count in
//            print("Count has been received in ViewController: \(count)")
                self.ballView.updateCountLabel(with: count)
        })
            .disposed(by: disposeBag)

        // Request in progreess:

        viewModel.vmRequestInProgressSubject
                          .bind(to: requestInProgressSubject)
                          .disposed(by: disposeBag)

        requestInProgressSubject
            .asObservable()
            .subscribe(onNext: { isInProgress in
                print("Request in progress == \(isInProgress)")

                if isInProgress {
                    DispatchQueue.main.async {
                        self.ballView.startInteraction()
                    }
                }

            })
        .disposed(by: disposeBag)
    }

    // MARK: - Lifecycle:

    override func loadView() {
        self.view = ballView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        setUpObservationClosures()
    }

    // MARK: - Events:

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        viewModel.shakeDetected()
        triggerShakeEvent.onNext(())
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

}

// MARK: - Private:

extension BallViewController {

    private func setUpObservationClosures() {

        viewModel.answerReceivedHandler = { [unowned self] answer in

            DispatchQueue.main.async {
                self.ballView.updateTextLabel(with: answer.text)
                self.ballView.updateShadow(with: answer.semanticColor)
                self.ballView.stopInteraction()
            }

        }
    }

}
