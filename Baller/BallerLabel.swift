//
//  BallerLabel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/3/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class BallerLabel: UILabel {

    convenience init(text: String? = nil,
                     numberOfLines: Int = 0,
                     fontSize: CGFloat = AppFont.Size.default) {
        self.init()

        self.text = text
        self.numberOfLines = numberOfLines
        font = AppFont.standard(withSize: fontSize)
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        allowsDefaultTighteningForTruncation = true

        if #available(iOS 13.0, *) {
            textColor = .label
        } else {
            textColor = .black
        }

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

}
