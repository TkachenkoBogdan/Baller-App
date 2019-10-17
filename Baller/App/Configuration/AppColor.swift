//
//  AppColor.swift
//  Baller
//
//  Created by Богдан Ткаченко on 17.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

enum AppColor {


    static let primeColor = ColorName.indigo.color

    static var globalTint: UIColor {
        return UIColor.forInterfaceStyle(light: .blue,
                                         dark: ColorName.customRed.color)
    }

    //Colors used for background gradient animation:

    static var animatedColor1: UIColor {
        return UIColor.forInterfaceStyle(light: ColorName.animatedBackgroundLight1.color,
                                         dark: ColorName.animatedBackgroundDark1.color)
    }

    static var animatedColor2: UIColor {
        return UIColor.forInterfaceStyle(light: ColorName.animatedBackgroundLight2.color,
                                         dark: ColorName.animatedBackgroundDark2.color)
    }

    static var animatedColor3: UIColor {
        return UIColor.forInterfaceStyle(light: ColorName.animatedBackgroundLight3.color,
                                         dark: ColorName.animatedBackgroundDark3.color)
    }
}
