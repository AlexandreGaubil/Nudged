//
//  create_alert_view.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-26.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

func create_alert_view(title: String, message: String?, okButtonTitle: String) -> UIAlertController {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okButton = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
    alertVC.addAction(okButton)
    return alertVC
}
