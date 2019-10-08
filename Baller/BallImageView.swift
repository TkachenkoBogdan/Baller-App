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
        self.setShadow(with: .black)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Public Logic:

    func rollToScreen() {
        roll(withIntensity: 800)
    }

    func appearWithAnimation() {
        self.layer.animateOpacityChange(withDuration: 1)
    }

    func roll(withIntensity intensity: CGFloat = 100, completion: ( () -> Void)? = nil) {

        let rotationRange = CGFloat.random(in: (CGFloat.pi/1.5)...CGFloat.pi)

        self.transform = CGAffineTransform(rotationAngle: rotationRange)
            .scaledBy(x: 0.5, y: 0.5)
            .translatedBy(x: CGFloat.random(in: -intensity...intensity),
                          y: CGFloat.random(in: -intensity...intensity))

        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 2,
                       options: [.curveEaseInOut, .allowUserInteraction],
                       animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.updateShadowColor(with: AppColor.primeColor, duration: 1)
        })
    }

    func updateShadowColor(with color: UIColor, duration: CFTimeInterval = 0.6) {
        layer.updateShadowColor(with: color, duration: duration)
        shrink()
    }

    // MARK: - Private Logic:

    @objc private func ballPressed() {
        flutter(withIntensity: 15)
    }

    private func setShadow(with color: UIColor) {

        UIView.animate(withDuration: 1.5) {
            self.layer.addShadow(color: color, opacity: 0.8, radius: 30)
        }
    }

    private func setUpBallGestureRecognizer() {
        self.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ballPressed))
        self.addGestureRecognizer(tapRecognizer)
    }
}
