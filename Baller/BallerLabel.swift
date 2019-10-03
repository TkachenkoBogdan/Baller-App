//
//  BallerLabel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/3/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class BallerLabel: UILabel {

    convenience init(text: String? = nil, fontSize: CGFloat = GlobalFont.Size.default) {
        self.init()

        self.text = text
        font = GlobalFont.standard(withSize: fontSize)

        if #available(iOS 13.0, *) {
            textColor = .label
        } else {
            textColor = .white
        }

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

}
