//
//  UIView+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 8/23/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension UIView {

    func roll(withIntensity intensity: CGFloat = 100) {

        let rotationRange = CGFloat.random(in: (CGFloat.pi/1.5)...CGFloat.pi)

        self.transform = CGAffineTransform(rotationAngle: rotationRange)
            .scaledBy(x: 0.5, y: 0.5)
            .translatedBy(x: CGFloat.random(in: -intensity...intensity),
                          y: CGFloat.random(in: -intensity...intensity))

        UIView.animate(withDuration: 3.5, delay: 0, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 2,
                       options: [.curveEaseInOut],
                       animations: {
                        self.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}
