//
//  ViewController.swift
//  Baller
//
//  Created by Богдан Ткаченко on 28.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

class ViewController<T>: UIViewController where T: UIView {

    // swiftlint:disable:next force_cast
    var rootView: T { return view as! T }

    override func loadView() {
        view = T()
    }
}
