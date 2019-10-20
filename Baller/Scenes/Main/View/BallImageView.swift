//
//  BallImageView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/6/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

final class BallImageView: UIImageView {

    // MARK: - Init:

    override init(image: UIImage?) {
        super.init(image: image)

        setUpBallGestureRecognizer()
        setShadow(with: .black)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Public:

    func appearOnScreen() {
        fallToPlace {
            self.updateShadowColorToDefault()
            self.flutter(withIntensity: 5, duration: 1)
        }
    }

    func startAnimations() {
        DispatchQueue.main.async {
            self.hover()
            self.layer.animateOpacityChange(withDuration: 1)
            self.flutter(duration: 1)
        }
    }

    func updateShadowColor(with color: UIColor, duration: CFTimeInterval = 0.6) {
        layer.updateShadowColor(with: color, duration: duration)
    }

    // MARK: - Private:

    @objc private func ballPressed() {
        flutter(withIntensity: 5, duration: 1.2)
    }

    private func setShadow(with color: UIColor) {
        UIView.animate(withDuration: 1.5) {
            self.layer.addShadow(color: color, opacity: 0.9, radius: 50)
        }
    }

    private func updateShadowColorToDefault() {
        layer.updateShadowColor(with: AppColor.primeColor, duration: 0.7)
    }

    private func setUpBallGestureRecognizer() {
        isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ballPressed))
        addGestureRecognizer(tapRecognizer)
    }
}

// MARK: - Animations:

extension BallImageView {

    func roll(withIntensity intensity: CGFloat = 100,
              scaledBy scale: Double = 0.5,
              completion: (() -> Void)? = nil) {

        let rotationRange = CGFloat.random(in: (CGFloat.pi/1.5)...CGFloat.pi)

        self.transform = CGAffineTransform(rotationAngle: rotationRange)
            .scaledBy(x: 0.6, y: 0.6)
            .translatedBy(x: CGFloat.random(in: -intensity...intensity),
                          y: CGFloat.random(in: -intensity...intensity))

        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 2,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.updateShadowColorToDefault()
            self.pulse()
            completion?()
        })
    }

    private func hover() {

        let wobble = CAKeyframeAnimation(keyPath: "transform.translation.x")
        wobble.duration = 4
        wobble.values = [0.0, -.pi/1.0, 0.0, .pi/1.0, 0.0]
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]

        let positionY = CASpringAnimation(keyPath: "position.y")
        positionY.damping = 20
        positionY.mass = 100
        positionY.stiffness = 50
        positionY.initialVelocity = 0.5
        positionY.fromValue = self.layer.position.y - 5
        positionY.toValue = self.layer.position.y + 10

        let shadowRadius = CABasicAnimation(keyPath: "shadowRadius")
        shadowRadius.fromValue = 25
        shadowRadius.toValue = 90

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 4
        animationGroup.repeatDuration = .infinity
        animationGroup.animations = [wobble, positionY, shadowRadius]
        animationGroup.autoreverses = true
        animationGroup.fillMode = .both

        self.layer.add(animationGroup, forKey: nil)
    }
}
