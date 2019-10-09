//
//  ReusableView.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/2/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
