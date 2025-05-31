//
//  ChildAVC.swift
//  Test
//
//  Created by Vanine Ghazaryan on 22.09.23.
//

import UIKit

final class ChildAVC: UIViewController {
    private let swapButton: SwapButton = SwapButton()
    var swapButtonAction: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        view.addSubview(swapButton)
        setupSwapButton()
        hideButton()
    }
    
    private func setupSwapButton() {
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        swapButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        swapButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        swapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        swapButton.action = swapButtonAction
    }
    
    func hideButton() {
        swapButton.isHidden = true
    }
    
    func showButton() {
        swapButton.isHidden = false
    }
}

