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
    let electricity_cost_per_kWh = 0
    let electricity_size_dependant_usage = 0.52
    let electricity_fixed_usage = 0.08
    let electricity_number_of_inhabitants_dependant_usage = 0.4
}

let normal_house_one = NormalHouseInNeighborhood(apartment_electricity_use: 0, separate_house_electricity_use: 0, house_sharing_walls_electricity_use: 0, apartment_size: 0, separate_house_size: 0, house_sharing_walls_size: 0)
