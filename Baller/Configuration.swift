//
//  Configuration.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/3/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

enum AppConstants {

    static let shakeAttempts = L10n.numberOfShakeAttempts
}

enum AppColor {

    static let globalTint = UIColor.white
    static let primeColor = UIColor.magenta
}

enum AppFont {

    static func standard(withSize size: CGFloat = Size.default) -> UIFont {
        return FontFamily.Futura.condensedMedium.font(size: size)
    }

    enum Size {

        static let `default`: CGFloat = 17

        static let statusLabel: CGFloat = 37
        static let answerLabel: CGFloat = 28

        static let dateLabel: CGFloat = 12
    }
}
