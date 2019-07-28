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
    var apartment_electricity_use = 0.0
    var separate_house_electricity_use = 0.0
    var house_sharing_walls_electricity_use = 0.0
    var apartment_size = 0.0
    var separate_house_size = 0.0
    var house_sharing_walls_size = 0.0
}
