//
//  HomeViewController.swift
//  Test
//
//  Created by Vanine Ghazaryan on 23.09.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        let containerVC = ContainerViewController(nibName: nil, bundle: nil)
        navigationController?.pushViewController(containerVC, animated: true)
    }
}
