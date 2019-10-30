//
//  FlowCoordinator+.swift
//  Baller
//
//  Created by Богдан Ткаченко on 28.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

extension FlowCoordinator {

    var navigationController: UINavigationController? {
        return containerViewController as? UINavigationController
    }

    func push(viewController: UIViewController) {
        guard let navigationController = navigationController else {
            fatalError("attempt to push without navigationController \(self)")
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func pop() {
        guard let navigationController = navigationController else {
            fatalError("attempt to pop without navigationController \(self)")
        }
        navigationController.popViewController(animated: true)
    }

    func dismiss() {
        guard let navigationController = navigationController else {
            fatalError("attempt to dismiss without navigationController \(self)")
        }
        navigationController.dismiss(animated: true, completion: nil)
    }

    func popToRoot() {
        guard let navigationController = navigationController else {
            fatalError("attempt to pop without navigationController \(self)")
        }
        navigationController.dismiss(animated: true, completion: nil)
    }

    func present(viewController: UIViewController) {
        guard let containerViewController = containerViewController else {
            fatalError("attempt to present without navigationController \(self)")
        }
        containerViewController.present(viewController, animated: true, completion: nil)
    }

}
