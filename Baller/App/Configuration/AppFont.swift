//
//  AppFont.swift
//  Baller
//
//  Created by Богдан Ткаченко on 17.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

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
