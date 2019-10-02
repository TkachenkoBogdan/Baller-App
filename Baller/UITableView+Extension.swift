//
//  UITableView+Extension.swift
//  Baller
//
//  Created by Богдан Ткаченко on 10/2/19.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)

    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

}

extension UITableViewCell: ReusableView { }
