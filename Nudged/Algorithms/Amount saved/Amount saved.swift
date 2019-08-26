//
//  Amount saved.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-08-02.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func amount_saved() -> (Double, ComparisonToOtherHousesKind) {
    var normal_electricity_usage = 0.0
    
    //let user_electricity_usage = user
    
    switch user_house?.kind_of_house {
    case .apartment?: normal_electricity_usage = normal_house_one.apartment_electricity_use
    case .house_sharing_walls?: normal_electricity_usage = normal_house_one.house_sharing_walls_electricity_use
    case .separate_house?: normal_electricity_usage = normal_house_one.separate_house_electricity_use
    case nil: break
    }
    
    if (global_history.electricity_usage - normal_electricity_usage) > 0 {
        return (Double(round((global_history.electricity_usage - normal_electricity_usage) * global_parameters.electricity_cost_per_kWh * 10) / 10), .worse_than_normal)
    } else {
        return (Double(round((normal_electricity_usage - global_history.electricity_usage) * global_parameters.electricity_cost_per_kWh * 10) / 10), .better_than_normal)
    }
}
