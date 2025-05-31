//
//  SlidePresentationController.swift
//  Test
//
//  Created by Vanine Ghazaryan on 23.09.23.
//

import UIKit

final class SlidePresentationController: UIPresentationController {

    private var dimmingView: UIView!
    private let position: SlidePresentationZPosition
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        
        switch position {
        case .under:
            frame.origin.y = containerView!.frame.height * 0.1
        case .top:
            frame.origin.y = containerView!.frame.height * 0.2
        }
        return frame
    }
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         position: SlidePresentationZPosition) {
        self.position = position
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        guard let dimmingView = dimmingView else {
            return
        }
        containerView?.insertSubview(dimmingView, at: 0)
        
        let topSpace = position == .top ? UIScreen.main.bounds.height * 0.1 : 0
        dimmingView.centerXAnchor.constraint(equalTo: containerView!.centerXAnchor).isActive = true
        dimmingView.heightAnchor.constraint(equalToConstant: frameOfPresentedViewInContainerView.height + topSpace).isActive = true
        dimmingView.widthAnchor.constraint(equalToConstant: frameOfPresentedViewInContainerView.width).isActive = true
        dimmingView.bottomAnchor.constraint(equalTo: containerView!.bottomAnchor).isActive = true
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        switch position {
        case .under:
            return CGSize(width: parentSize.width, height: parentSize.height*0.9)
        case .top:
            return CGSize(width: parentSize.width, height: parentSize.height*0.8)
        }
    }
}

private extension SlidePresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = .clear
        dimmingView.alpha = 0
        dimmingView.isUserInteractionEnabled = true
        
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        let navVC = presentingViewController.presentingViewController as? UINavigationController
        (navVC?.topViewController as? ContainerViewController)?.swapVCS(top: presentedViewController)
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
 }
