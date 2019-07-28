//
//  HistoryElectricityConsumptionVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HistoryElectricityConsumptionVC: UIViewController {
    
    var weekly_history: [Double?] = []
    var monthly_history: [Double?] = []
    var yearly_history: [[Double?]?] = []
    var all_history: [[Double?]?] = []
    
    var week_dates: [String] = []
    var month_dates: [String] = []
    
    @IBOutlet weak var graph_stack_view: UIStackView!
    @IBOutlet weak var time_graph_selector_SC: UISegmentedControl!
    @IBOutlet weak var history_scroll_view: UIScrollView!
    
    @IBAction func time_graph_selector_SC_value_changed(_ sender: Any) {
        switch time_graph_selector_SC.selectedSegmentIndex {
        case 0: break
        case 1: break
        case 2: break
        case 3: break
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "dd_MM_yyyy"

        week_dates = []
        month_dates = []
        weekly_history = []
        monthly_history = []
        yearly_history = []
        all_history = []
        
        
        for i in [0, 24, 48, 72, 96, 120, 144] {
            print(Date.init(timeIntervalSinceNow: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0))
            let date = Date.init(timeIntervalSinceNow: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0)
            week_dates.append(date_formatter.string(from: date))
        }
        for i in [0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240, 264, 288, 312, 336, 360, 384, 408, 432, 456, 480, 504, 528, 552, 576, 600, 624, 648, 672, 696, 720] {
            print(Date.init(timeIntervalSinceNow: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0))
            let date = Date.init(timeIntervalSinceNow: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0)
            month_dates.append(date_formatter.string(from: date))
        }
        for i in 0...11 {
            
        }
        
        
        read_user_information(identifier: "house1", completion: { houseDetails, error in
            for week_date in self.week_dates {
                self.weekly_history.append(houseDetails?.electricity_history?[week_date])
            }
            for month_date in self.month_dates {
                self.monthly_history.append(houseDetails?.electricity_history?[month_date])
            }
            
            
            
        })
        
    }
    
    func set_graph_to_week_view() {
        
    }
    
    func set_graph_to_month_view() {
        
    }
    
    func set_graph_to_year_view() {
        
    }
    
    func set_graph_to_all_view() {
        
    }    
}
