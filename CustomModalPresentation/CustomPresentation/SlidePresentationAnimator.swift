//
//  SlidePresentationAnimator.swift
//  Test
//
//  Created by Vanine Ghazaryan on 23.09.23.
//

import UIKit

final class SlidePresentationAnimator: NSObject {

    let direction: SlidePresentationZPosition
    let isPresentation: Bool
    
    // MARK: - Initializers
    init(direction: SlidePresentationZPosition, isPresentation: Bool) {
        self.direction = direction
        self.isPresentation = isPresentation
        super.init()
    }
}

extension SlidePresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key: UITransitionContextViewControllerKey = isPresentation ? .to : .from
        guard let controller = transitionContext.viewController(forKey: key)
        else { return }
        
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch direction {
        case .top:
            dismissedFrame.origin.x = -presentedFrame.width
        case .under:
            dismissedFrame.origin.x = -presentedFrame.width
        }
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                controller.view.frame = finalFrame
            }, completion: { finished in
                if !self.isPresentation {
                    controller.view.removeFromSuperview()
                }
                transitionContext.completeTransition(finished)
            })
    }
}
