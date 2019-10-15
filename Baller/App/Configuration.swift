//
//  Configuration.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/3/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

enum AppConstants {

    static let appModelVersion: UInt64 = 2
    static let shakeAttempts = L10n.numberOfShakeAttempts
}

enum AppFont {

    static func standard(withSize size: CGFloat) -> UIFont {
        return FontFamily.Futura.condensedMedium.font(size: size)
    }

    enum Size {

        static let `default`: CGFloat = 14

        static let statusLabel: CGFloat = 37
        static let answerLabel: CGFloat = 22

        static let cellAnswerLabel: CGFloat = 15
        static let cellDateLabel: CGFloat = 12
    }
}

enum AppColor {

    static let primeColor = ColorName.indigo.color

    static var globalTint: UIColor {
        return UIColor.forInterfaceStyle(light: .blue,
                                         dark: ColorName.customRed.color)
    }

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
