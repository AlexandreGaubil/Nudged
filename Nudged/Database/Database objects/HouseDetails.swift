//
//  house_details.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation
import CoreLocation

class HouseDetails {
    var identifier: String? = nil
    var electricity_history: [String: Double]? = nil
    var number_of_house_inhabitants: Int? = nil
    var location: CLLocationCoordinate2D? = nil
    var postal_code: String? = nil
    var house_size: Double? = nil
    var kind_of_house: HouseType? = nil
    var electricity_usage: Double? = nil
    
    init(identifier: String, electricity_history: [String: Double], number_of_house_inhabitants: Int, location: CLLocationCoordinate2D, postal_code: String, house_size: Double, kind_of_house: HouseType) {
        self.identifier = identifier
        self.electricity_history = electricity_history
        self.number_of_house_inhabitants = number_of_house_inhabitants
        self.location = location
        self.postal_code = postal_code
        self.house_size = house_size
        self.kind_of_house = kind_of_house
    }
    
    convenience init(_ dictionary: [String: Any], identifier: String) {
        let electricity_history = (dictionary["e"] as? [String: Double]) ?? ["": 0]
        let number_of_house_inhabitants = (dictionary["h"] as? Int) ?? 0
        let location = (dictionary["l"] as? CLLocationCoordinate2D) ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let postal_code = (dictionary["p"] as? String) ?? ""
        let house_size = (dictionary["s"] as? Double) ?? 0.0
        let string_kind_of_house = (dictionary["k"] as? String) ?? ""
        var kind_of_house: HouseType = .apartment
        switch string_kind_of_house {
        case "a": kind_of_house = .apartment
        case "sh": kind_of_house = .separate_house
        case "hw": kind_of_house = .house_sharing_walls
        default: break
        }
        self.init(identifier: identifier, electricity_history: electricity_history, number_of_house_inhabitants: number_of_house_inhabitants, location: location, postal_code: postal_code, house_size: house_size, kind_of_house: kind_of_house)
    }
}
