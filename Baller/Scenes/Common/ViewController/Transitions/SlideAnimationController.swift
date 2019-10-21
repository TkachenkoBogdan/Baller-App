//
//  TransitionAnimator.swift
//  Baller
//
//  Created by Богдан Ткаченко on 17.10.2019.
//  Copyright © 2019 Богдан Ткаченко. All rights reserved.
//

import UIKit

final class SlideAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private let viewControllers: [UIViewController]?
    private let transitionDuration: TimeInterval = 0.3

    // MARK: - Init:

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    // MARK: - UIViewControllerAnimatedTransitioning:

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),

            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)

            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame

        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width

        toView.frame = toFrameStart

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: { success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

    // MARK: - Private:

    private func getIndex(forViewController viewController: UIViewController) -> Int? {
        guard let viewControllers = self.viewControllers else { return nil }
        for (index, thisVC) in viewControllers.enumerated() where thisVC == viewController {
            return index
        }
        return nil
    }
}
