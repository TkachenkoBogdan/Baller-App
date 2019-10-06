//
//  CALayer+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/4/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension CALayer {

    func addShadow(height: CGFloat = 1,
                   width: CGFloat = 0,
                   color: UIColor = .black,
                   opacity: Float = 0.25,
                   radius: CGFloat = 8) {

        shadowOffset = CGSize(width: width, height: height)
        shadowColor = color.cgColor
        shadowOpacity = opacity
        shadowRadius = radius
    }

    func removeShadow() {

        shadowOffset = .zero
        shadowColor = UIColor.clear.cgColor
        shadowOpacity = 0.0
        shadowRadius = 0
    }

    func updateShadowColor(with color: UIColor) {
        let animation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = self.shadowColor
        animation.toValue = color.cgColor
        animation.duration = 1.5

        add(animation, forKey: animation.keyPath)
        shadowColor = color.cgColor
    }
}