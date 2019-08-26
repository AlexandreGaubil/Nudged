//
//  Comparison-algo.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-23.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum ComparisonToOtherHousesKind {
    case better_than_normal
    case worse_than_normal
    case equal_to_normal
}

func compare_house_consumption_to_houses_with_same_postal_code() -> (Int, ComparisonToOtherHousesKind) {
    
    let normal_consumption = normal_electric_consumption(house_type: user_house?.kind_of_house ?? HouseType.apartment, house_surface: user_house?.size_of_house ?? 0, number_of_house_inhabitants: user_house?.number_of_inhabitants ?? 0, normal_house_in_neighborhood: normal_house_one)
    print((100 * global_history.electricity_usage) / normal_consumption)
    if !(normal_consumption.isNaN) {
        if Int(100 * global_history.electricity_usage / normal_consumption) < 100 {
            return (100 - Int(100 * global_history.electricity_usage / normal_consumption), .better_than_normal)
        } else if Int(100 * global_history.electricity_usage / normal_consumption) > 100 {
            return (Int(100 * global_history.electricity_usage / normal_consumption) - 100, .worse_than_normal)
        } else {
            return (100, .equal_to_normal)
        }
    } else {
        return (0, .equal_to_normal)
    }
}
