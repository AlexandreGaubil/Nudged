//
//  label_height.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-08-31.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

func frame_for_label(label: UILabel) -> CGRect {
    let new_label = UILabel(frame: CGRect(x: label.frame.minX, y: label.frame.minY, width: label.frame.width, height: CGFloat.greatestFiniteMagnitude))
    print(label.frame.minY)
    new_label.font = label.font
    new_label.text = label.text
    new_label.numberOfLines = 0
    new_label.lineBreakMode = NSLineBreakMode.byWordWrapping
    
    new_label.sizeToFit()
    return new_label.frame
}
