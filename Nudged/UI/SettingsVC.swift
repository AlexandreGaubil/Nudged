//
//  SettingsVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-09-06.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
    }
    
}
