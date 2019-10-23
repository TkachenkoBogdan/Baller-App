//
//  BallerLabel.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/3/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

final class BallerLabel: UILabel {

    // MARK: - Init:

    convenience init(text: String? = nil,
                     numberOfLines: Int = 0,
                     fontSize: CGFloat = AppFont.Size.default) {
        self.init()

        configure(text, numberOfLines, fontSize)

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError(L10n.FatalErrors.initCoder)
    }

    // MARK: - Public Logic:

    var animatesTextChanges = false
    var animationDuration: CFTimeInterval = 0.3
    var animationType: CATransitionType = .fade

    override var text: String? {
        willSet {
            animatesTextChanges ? animatedTransition(withType: animationType, animationDuration) : ()
        }
    }

    // MARK: - Private:

    private func configure(_ text: String?, _ numberOfLines: Int, _ fontSize: CGFloat) {
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
}
