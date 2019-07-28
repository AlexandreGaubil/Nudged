//
//  make_button_inverted.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-26.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

extension UIButton {
    func make_button_inverted() {
        self.widthAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        self.layer.cornerRadius = 5
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.7647058824, blue: 0.2156862745, alpha: 1) //13, 133, 254
        self.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
