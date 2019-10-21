//
//  AppColor.swift
//  Baller
//
//  Created by Богдан Ткаченко on 17.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

enum AppColor {

    static let primeColor = UIColor.forInterfaceStyle(light: .yellow,
                                                      dark: ColorName.indigo.color)

    static var globalTint: UIColor {
        return UIColor.forInterfaceStyle(light: ColorName.animatedBackgroundPrimaryLight.color,
                                         dark: ColorName.customRed.color)
    }

    // Colors used for background gradient animation:

    static var animatedBackgroundPrimary: UIColor {
        return UIColor.forInterfaceStyle(light: ColorName.animatedBackgroundPrimaryLight.color,
                                         dark: ColorName.animatedBackgroundPrimaryDark.color)
    }

    static var animatedBackgroundSecondary: UIColor {
        return UIColor.forInterfaceStyle(light: ColorName.animatedBackgroundSecondaryLight.color,
                                         dark: ColorName.animatedBackgroundSecondaryDark.color)
    }

}
