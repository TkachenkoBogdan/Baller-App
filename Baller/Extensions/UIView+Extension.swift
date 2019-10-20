//
//  UIView+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

protocol Animatable {}

extension UIView {

    func pushTransition(_ duration: CFTimeInterval) {

        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }

    func flutter(withIntensity intensity: CGFloat = 10,
                 duration: CFTimeInterval = 0.4) {

        self.transform = CGAffineTransform(translationX: intensity, y: 0)

        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.05,
                       initialSpringVelocity: 15,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        })
    }

    func pulse() {

        self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

        UIView.animate(withDuration: 0.8, delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        })
    }

    func fallToPlace(completion: (() -> Void)? = nil) {
        self.transform = CGAffineTransform(translationX: 0, y: -bounds.height / 2)
           .rotated(by: .pi)

        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 10,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: { _ in
            completion?()
        })
    }
}
