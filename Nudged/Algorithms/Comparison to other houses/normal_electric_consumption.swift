//
//  normal.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-26.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func normal_electric_consumption(house_type: HouseType, house_surface: Double, number_of_house_inhabitants: Int, normal_house_in_neighborhood: NormalHouseInNeighborhood) -> Double {
    
    var medium_use_of_electricity_of_neighbourhood = 0.0
    var medium_house_size_of_neighbourhood = 0.0
    
    switch house_type {
    case .apartment:
        medium_house_size_of_neighbourhood = normal_house_in_neighborhood.apartment_size
        medium_use_of_electricity_of_neighbourhood = normal_house_in_neighborhood.apartment_electricity_use
        
    case .house_sharing_walls:
        medium_house_size_of_neighbourhood = normal_house_in_neighborhood.house_sharing_walls_size
        medium_use_of_electricity_of_neighbourhood = normal_house_in_neighborhood.house_sharing_walls_electricity_use
        
    case .separate_house:
        medium_house_size_of_neighbourhood = normal_house_in_neighborhood.separate_house_size
        medium_use_of_electricity_of_neighbourhood = normal_house_in_neighborhood.separate_house_electricity_use
        
    }
    
    //Lights + heating + cooling
    let size_dependant_usage = 0.52 * (medium_use_of_electricity_of_neighbourhood / medium_house_size_of_neighbourhood) * house_surface
    
    //Fridge + TV
    let fixed_usage = 0.08 * medium_use_of_electricity_of_neighbourhood
    
    //Water Heating + Computer and tech charging
    let number_of_inhabitants_dependant_usage = 0.4 * (medium_use_of_electricity_of_neighbourhood / medium_house_size_of_neighbourhood) * Double(number_of_house_inhabitants)
    
    
    return size_dependant_usage + fixed_usage + number_of_inhabitants_dependant_usage
}
