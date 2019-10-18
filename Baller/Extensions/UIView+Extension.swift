//
//  UIView+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension UIView {

    func pushTransition(_ duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }

    func flutter(withIntensity intensity: CGFloat = 10, duration: CFTimeInterval = 0.4) {
        self.transform = CGAffineTransform(translationX: intensity, y: 0)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.05,
                       initialSpringVelocity: 15,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        })
    }

    func shrink() {
        self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 2,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        })
    }
}
