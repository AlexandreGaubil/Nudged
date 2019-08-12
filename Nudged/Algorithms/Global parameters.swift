//
//  Global parameters.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-08-12.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

let global_parameters = GlobalParameters()

struct GlobalParameters {
    let electricity_cost_per_kWh = 0.5
    let electricity_size_dependant_usage = 0.52
    let electricity_fixed_usage = 0.08
    let electricity_number_of_inhabitants_dependant_usage = 0.4
}

let normal_house_one = NormalHouseInNeighborhood(apartment_electricity_use: 250, separate_house_electricity_use: 500, house_sharing_walls_electricity_use: 450, apartment_size: 90, separate_house_size: 120, house_sharing_walls_size: 120, medium_number_of_inhabitants: 2.67)

struct UserHouse {
    let number_of_inhabitants: Int
    let size_of_house: Double
    let kind_of_house: HouseType
}

var user_house: UserHouse?
