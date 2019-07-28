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
    
    init(identifier: String, electricity_history: [String: Double], number_of_house_inhabitants: Int, location: CLLocationCoordinate2D, postal_code: String) {
        self.identifier = identifier
        self.electricity_history = electricity_history
        self.number_of_house_inhabitants = number_of_house_inhabitants
        self.location = location
        self.postal_code = postal_code
    }
    
    convenience init(_ dictionary: [String: Any], identifier: String) {
        let electricity_history = (dictionary["e"] as? [String: Double]) ?? ["": 0]
        let number_of_house_inhabitants = (dictionary["h"] as? Int) ?? 0
        let location = (dictionary["l"] as? CLLocationCoordinate2D) ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let postal_code = (dictionary["p"] as? String) ?? ""
        self.init(identifier: identifier, electricity_history: electricity_history, number_of_house_inhabitants: number_of_house_inhabitants, location: location, postal_code: postal_code)
    }
}
