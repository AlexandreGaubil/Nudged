//
//  HistoryElectricityConsumptionVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HistoryElectricityConsumptionVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        read_user_information(identifier: "house1", completion: { houseDetails, error in
            print(error.debugDescription)
            print(houseDetails?.electricity_history)
            print(houseDetails?.identifier)
        })
        
    }
    
    
}

