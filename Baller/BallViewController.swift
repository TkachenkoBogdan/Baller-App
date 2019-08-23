//
//  ViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/16/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class BallViewController: UIViewController {
    
    private let answerProvider: AnswerProviding = AnswerProvider()
    
    // MARK: - Outlets:
    @IBOutlet private var ballImageView: UIImageView?
    @IBOutlet private var answerLabel: UILabel?
    @IBOutlet private var statusLabel: UILabel?
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        self.ballImageView?.shake()
        self.setLabelsVisibility(to: true)
        
        answerProvider.getAnswer { (result) in
            switch result {
            case .success(let answer):
                self.updateAnswerLabel(with: answer.title)
            case .failure:
                self.updateAnswerLabel(with: "Oh, snap! Try again")
            }
        }
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
