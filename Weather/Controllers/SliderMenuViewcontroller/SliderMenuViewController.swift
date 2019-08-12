//
//  SliderMenuViewController.swift
//  Weather
//
//  Created by Humaxvina on 8/12/19.
//  Copyright © 2019 Humaxvina. All rights reserved.
//

import UIKit
import SlideMenu3D

class SliderMenuViewController: HKSlideMenu3DController {
    
    let menuVC = MenuViewController.fromStoryboard(.menu)
    let mainVC = MainViewController.fromStoryboard(.main)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.menuVC?.delegate = self
        self.menuViewController = self.menuVC
        if let controller = self.mainVC {
            controller.delegate = self
            self.mainViewController = controller
            self.distanceOpenMenu = controller.view.frame.size.width - 100
        }
        self.enablePan = false
    }
}

extension SliderMenuViewController: MenuViewControllerDelegate {
    
    func didSelectAddress(at index: Int) {
        self.toggleMenu()
        self.mainVC?.selectAddress(at: index)
    }
    
    func didDeleteAddress(at index: Int) {
        self.mainVC?.deleteAddress(at: index)
    }
}

extension SliderMenuViewController: MainViewControllerDelegate {
    func didAddAddress() {
        self.menuVC?.reloadData()
    }
    
    func didTouchToggleMenu() {
        self.toggleMenu()
    }
}
