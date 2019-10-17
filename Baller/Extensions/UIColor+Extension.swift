//
//  UIColor+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 11.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension UIColor {

    static func forInterfaceStyle(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        } else {
            return light
        }
    }

}
