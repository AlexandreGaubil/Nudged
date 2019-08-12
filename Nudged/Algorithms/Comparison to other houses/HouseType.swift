//
//  HouseType.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-26.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

enum HouseType {
    case apartment
    case separate_house
    case house_sharing_walls
}

struct NormalHouseInNeighborhood {
    var apartment_electricity_use: Double
    var separate_house_electricity_use: Double
    var house_sharing_walls_electricity_use: Double
    var apartment_size: Double
    var separate_house_size: Double
    var house_sharing_walls_size: Double
    var medium_number_of_inhabitants: Double
}
