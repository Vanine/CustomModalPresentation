//
//  SlidePresentationManager.swift
//  Test
//
//  Created by Vanine Ghazaryan on 23.09.23.
//

import UIKit

final class SlidePresentationManager: NSObject {
    var position: SlidePresentationZPosition = .under
    var disableCompactHeight = false
}

extension SlidePresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        let presentationController = SlidePresentationController(
            presentedViewController: presented,
            presenting: presenting,
            position: position
        )
        return presentationController
    }
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlidePresentationAnimator(direction: position, isPresentation: true)
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return SlidePresentationAnimator(direction: position, isPresentation: false)
    }
}
