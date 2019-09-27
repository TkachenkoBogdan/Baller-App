//
//  ViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit
import Reusable

class MainScreenViewController: UIViewController, StoryboardSceneBased {

    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)

    var viewModel: MainScreenViewModel?

    // MARK: - Outlets:
    @IBOutlet private var ballImageView: UIImageView?
    @IBOutlet private var answerLabel: UILabel?
    @IBOutlet private var statusLabel: UILabel?

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }

        self.ballImageView?.shake()
        self.setLabelsVisibility(to: true)

        viewModel?.getAnswer(completion: { (answer) in
            self.updateAnswerLabel(with: answer)
        })
    }

    // MARK: - Navigation:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch StoryboardSegue.Main(segue) {
        case .toAnswers:
            guard let destintaion = segue.destination as? AnswersViewController else { return }
            destintaion.viewModel = AnswersViewModel(with: AnswerStoreJSON.shared)
        default:
            return
        }
    }

}

// MARK: - Helpers:
extension MainScreenViewController {

    private func updateAnswerLabel(with answer: String) {

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

    private func setLabelsVisibility(to isHidden: Bool) {
        self.answerLabel?.isHidden = isHidden
        self.statusLabel?.isHidden = isHidden
    }
}
