//
//  History object.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-08-12.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

class History {
    var weekly_history: [Double?] = []
    var monthly_history: [Double?] = []
    var yearly_history: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var all_history: [Double?] = []
    
    var week_dates: [String] = []
    var month_dates: [String] = []
    var year_dates: [String] = []
    var all_dates: [String] = []
    
    var electricity_usage = 0.0
}

let global_history = History()
