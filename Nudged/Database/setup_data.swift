//
//  setup_data.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-08-12.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import Foundation

func setup_data(completion: @escaping (Bool, Error?) -> Void) {
    
    let date_formatter = DateFormatter()
    date_formatter.dateFormat = "dd_MM_yyyy"
    let month_date_formatter = DateFormatter()
    month_date_formatter.dateFormat = "MM"
    let year_date_formatter = DateFormatter()
    year_date_formatter.dateFormat = "yyyy"
    
    for i in 0...100 {
        global_history.all_dates.append(String((Int(year_date_formatter.string(from: Date.init())) ?? 2019) - i))
    }
    
    for i in [0, 24, 48, 72, 96, 120, 144] {
        let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0)
        global_history.week_dates.append(date_formatter.string(from: date))
    }
    for i in [0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240, 264, 288, 312, 336, 360, 384, 408, 432, 456, 480, 504, 528, 552, 576, 600, 624, 648, 672, 696, 720] {
        let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0)
        global_history.month_dates.append(date_formatter.string(from: date))
    }
    switch month_date_formatter.string(from: Date.init()) {
    case "01": global_history.year_dates = ["JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA", "AP", "MR", "FE"]
    case "02": global_history.year_dates = ["FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA", "AP", "MR"]
    case "03": global_history.year_dates = ["MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA", "AP"]
    case "04": global_history.year_dates = ["AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA"]
    case "05": global_history.year_dates = ["MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN"]
    case "06": global_history.year_dates = ["JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE"]
    case "07": global_history.year_dates = ["JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU"]
    case "08": global_history.year_dates = ["AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE"]
    case "09": global_history.year_dates = ["SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC"]
    case "10": global_history.year_dates = ["OC", "SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO"]
    case "11": global_history.year_dates = ["NO", "OC", "SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE"]
    case "12": global_history.year_dates = ["DE", "NO", "OC", "SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA"]
    default: break
    }
    
    read_user_information(identifier: "0C97A1icrNmm5efNcPNT", completion: { houseDetails, error in
        
        //WEEK
        for week_date in global_history.week_dates {
            global_history.weekly_history.append(houseDetails?.electricity_history?[week_date])
        }
        //MONTH
        for month_date in global_history.month_dates {
            global_history.monthly_history.append(houseDetails?.electricity_history?[month_date])
            
            global_history.electricity_usage += houseDetails?.electricity_history?[month_date] ?? 0.0
        }
        //global_history.electricity_usage = Double(round(global_history.electricity_usage * 10) / 10)
        //global_history.electricity_usage = global_history.electricity_usage / 31
        
        //YEAR
        for i in 0...364 {
            var month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 0) - 1
            
            switch month_date_formatter.string(from: Date.init()) {
            case "01": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 1
            case "02": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 2
            case "03": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 3
            case "04": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 4
            case "05": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 5
            case "06": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 6
            case "07": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 7
            case "08": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 8
            case "09": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 9
            case "10": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 10
            case "11": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 11
            case "12": month_number = (Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 12
            default: break
            }
            month_number = month_number_for_current_result(result: month_number)
            let date_to_search = date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))
            if !(Int(month_date_formatter.string(from: Date.init())) == Int(month_date_formatter.string(from: Date.init() - TimeInterval(i * 24 * 3600))) && i > 60) {
                global_history.yearly_history[month_number] += Double(houseDetails?.electricity_history?[date_to_search] ?? 0) //+ global_history.yearly_history[month_number]
            }
        }
        //ALL
        for i in 0...365*10 {
            let date_to_search = date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))
            let year_number = (Int(year_date_formatter.string(from: Date.init())) ?? 2019) - (Int(year_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 1000)
            if houseDetails?.electricity_history?[date_to_search] != nil {
                while (global_history.all_history.count <= year_number) {
                    global_history.all_history.append(0)
                }
                if global_history.all_history[year_number] != nil {
                    global_history.all_history[year_number]! += houseDetails?.electricity_history?[date_to_search] ?? 0
                } else {
                    global_history.all_history[year_number] = houseDetails?.electricity_history?[date_to_search] ?? 0
                }
            }
        }
        completion(true, error)
    })
}

func month_number_for_current_result(result: Int) -> Int {
    switch result {
    case 0: return 0
    case 1: return 11
    case 2: return 10
    case 3: return 9
    case 4: return 8
    case 5: return 7
    case 6: return 6
    case 7: return 5
    case 8: return 4
    case 9: return 3
    case 10: return 2
    case 11: return 1
    case 12: return 0
    case -1: return 1
    case -2: return 2
    case -3: return 3
    case -4: return 4
    case -5: return 5
    case -6: return 6
    case -7: return 7
    case -8: return 8
    case -9: return 9
    case -10: return 10
    case -11: return 11
    case -12: return 12
    default: return 0
    }
}
