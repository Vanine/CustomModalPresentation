//
//  ViewController.swift
//  Test
//
//  Created by Vanine Ghazaryan on 22.09.23.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    lazy var slideInTransitioningDelegate = SlidePresentationManager()
    private let childAVC = ChildAVC(nibName: nil, bundle: nil)
    private let childBVC = ChildBVC(nibName: nil, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        slideInTransitioningDelegate.position = .under
        childAVC.transitioningDelegate = slideInTransitioningDelegate
        childAVC.modalPresentationStyle = .custom
        childAVC.swapButtonAction = { [weak self] in
            guard let self else { return }
            swapVCS(top: childAVC)
        }
        present(childAVC, animated: false)
        
        slideInTransitioningDelegate.position = .top
        childBVC.transitioningDelegate = slideInTransitioningDelegate
        childBVC.modalPresentationStyle = .custom
        childBVC.swapButtonAction = { [weak self] in
            guard let self else { return }
            swapVCS(top: childBVC)
        }
        childAVC.present(childBVC, animated: false)
    }
    
    func swapVCS(top: UIViewController) {
        if top is ChildBVC {
            self.dismiss(animated: true) { [self] in
                childAVC.hideButton()
                childBVC.hideButton()
                slideInTransitioningDelegate.position = .under
                childBVC.transitioningDelegate = slideInTransitioningDelegate
                present(childBVC, animated: true) { [self] in
                    slideInTransitioningDelegate.position = .top
                    childAVC.transitioningDelegate = slideInTransitioningDelegate
                    childAVC.showButton()
                    childBVC.present(childAVC, animated: true)
                }
            }
        } else {
            self.dismiss(animated: true) { [self] in
                childAVC.hideButton()
                childBVC.hideButton()
                slideInTransitioningDelegate.position = .under
                childAVC.transitioningDelegate = slideInTransitioningDelegate
                present(childAVC, animated: true) { [self] in
                    slideInTransitioningDelegate.position = .top
                    childBVC.transitioningDelegate = slideInTransitioningDelegate
                    childBVC.showButton()
                    childAVC.present(childBVC, animated: true)
                }
            }
        }
    }
}
