//
//  HistoryElectricityConsumptionVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit
import FirebaseFirestore
import ScrollableGraphView

class HistoryElectricityConsumptionVC: UIViewController, ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "week": return weekly_history[pointIndex] ?? 0.0
        case "month": return monthly_history[pointIndex] ?? 0.0
        case "year": return yearly_history[pointIndex]
        case "all": return all_history[pointIndex] ?? 0.0
        default: return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        switch type_of_graph {
        case "week": return (week_dates[pointIndex]).substring(toIndex: 2)
        case "month": return (month_dates[pointIndex]).substring(toIndex: 2)
        case "year": return year_dates[pointIndex]
        case "all": return all_dates[pointIndex]
        default: return "err"
        }
    }
    
    func numberOfPoints() -> Int {
        switch type_of_graph {
        case "week": return weekly_history.count
        case "month": return monthly_history.count
        case "year": return yearly_history.count
        case "all": return all_history.count
        default: return 0
        }
    }
    
    
    var weekly_history: [Double?] = []
    var monthly_history: [Double?] = []
    var yearly_history: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var all_history: [Double?] = []
    var type_of_graph = "week"
    
    let month_date_formatter = DateFormatter()
    let year_date_formatter = DateFormatter()
    
    var week_dates: [String] = []
    var month_dates: [String] = []
    var year_dates: [String] = []
    var all_dates: [String] = []
    
    @IBOutlet weak var graph_stack_view: UIStackView!
    @IBOutlet weak var time_graph_selector_SC: UISegmentedControl!
    @IBOutlet weak var history_scroll_view: UIScrollView!
    
    @IBAction func time_graph_selector_SC_value_changed(_ sender: Any) {
        reset_graph()
        switch time_graph_selector_SC.selectedSegmentIndex {
        case 0: set_graph_to_view(view: "week", data: weekly_history)
        case 1: set_graph_to_view(view: "month", data: monthly_history)
        case 2: set_graph_to_view(view: "year", data: yearly_history)
        case 3: set_graph_to_view(view: "all", data: all_history)
        default: set_graph_to_view(view: "week", data: weekly_history)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        month_date_formatter.dateFormat = "MM"
        year_date_formatter.dateFormat = "yyyy"
        let loading_view = UILabel(frame: CGRect(x: 0, y: 0, width: graph_stack_view.frame.width, height: graph_stack_view.frame.height))
        loading_view.textAlignment = .center
        loading_view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        loading_view.text = "Loading data..."
        graph_stack_view.addSubview(loading_view)
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "dd_MM_yyyy"
        
        week_dates = []
        month_dates = []
        year_dates = []
        all_dates = []
        weekly_history = []
        monthly_history = []
        yearly_history = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        all_history = []
        
        for i in 0...100 {
            all_dates.append(String(Int(year_date_formatter.string(from: Date.init())) ?? 2019 - i))
        }
        
        for i in [0, 24, 48, 72, 96, 120, 144] {
            let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0)
            week_dates.append(date_formatter.string(from: date))
        }
        for i in [0, 24, 48, 72, 96, 120, 144, 168, 192, 216, 240, 264, 288, 312, 336, 360, 384, 408, 432, 456, 480, 504, 528, 552, 576, 600, 624, 648, 672, 696, 720] {
            let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(exactly: Double(Date.init().timeIntervalSinceReferenceDate) - Double(i * 3600) ) ?? 0)
            month_dates.append(date_formatter.string(from: date))
        }
        switch month_date_formatter.string(from: Date.init()) {
        case "01": year_dates = ["JA", "FE", "MR", "AP", "MA", "JN", "JL", "AU", "SE", "OC", "NO", "DE"]
        case "02": year_dates = ["FE", "MR", "AP", "MA", "JN", "JL", "AU", "SE", "OC", "NO", "DE", "JA"]
        case "03": year_dates = ["MR", "AP", "MA", "JN", "JL", "AU", "SE", "OC", "NO", "DE", "JA", "FE"]
        case "04": year_dates = ["AP", "MA", "JN", "JL", "AU", "SE", "OC", "NO", "DE", "JA", "FE", "MR"]
        case "05": year_dates = ["MA", "JN", "JL", "AU", "SE", "OC", "NO", "DE", "JA", "FE", "MR", "AP"]
        case "06": year_dates = ["JN", "JL", "AU", "SE", "OC", "NO", "DE", "JA", "FE", "MR", "AP", "MA"]
        case "07": year_dates = ["JL", "AU", "SE", "OC", "NO", "DE", "JA", "FE", "MR", "AP", "MA", "JN"]
        case "08": year_dates = ["AU", "SE", "OC", "NO", "DE", "JA", "FE", "MR", "AP", "MA", "JN", "JL"]
        case "09": year_dates = ["SE", "OC", "NO", "DE", "JA", "FE", "MR", "AP", "MA", "JN", "JL", "AU"]
        case "10": year_dates = ["OC", "NO", "DE", "JA", "FE", "MR", "AP", "MA", "JN", "JL", "AU", "SE"]
        case "11": year_dates = ["NO", "DE", "JA", "FE", "MR", "AP", "MA", "JN", "JL", "AU", "SE", "OC"]
        case "12": year_dates = ["DE", "JA", "FE", "MR", "AP", "MA", "JN", "JL", "AU", "SE", "OC", "NO"]
        default: break
        }
        
        
        read_user_information(identifier: "0C97A1icrNmm5efNcPNT", completion: { houseDetails, error in
            
            for week_date in self.week_dates {
                self.weekly_history.append(houseDetails?.electricity_history?[week_date])
            }
            for month_date in self.month_dates {
                self.monthly_history.append(houseDetails?.electricity_history?[month_date])
            }
            for i in 0...364 {
                
                var month_number = 0
                
                switch self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24)) {
                case "1": month_number = 0
                case "2": month_number = 1
                case "3": month_number = 2
                case "4": month_number = 3
                case "5": month_number = 4
                case "6": month_number = 5
                case "7": month_number = 6
                case "8": month_number = 7
                case "9": month_number = 8
                case "10": month_number = 9
                case "11": month_number = 10
                case "12": month_number = 11
                default: break
                }
                
                let date_to_search = date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))
                //if (Int(self.month_date_formatter.string(from: Date.init())) ?? 14 - 1 == month_number) && (Int(self.day_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 0 >= Int(self.day_date_formatter.string(from: Date.init())) ?? 0) {
                self.yearly_history[month_number] = Double(houseDetails?.electricity_history?[date_to_search] ?? 0) + self.yearly_history[month_number]
                //}
            }
            
            for i in 0...365*10 {
                let date_to_search = date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))
                let year_number = (Int(self.year_date_formatter.string(from: Date.init())) ?? 2019) - (Int(self.year_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 1000)
                if houseDetails?.electricity_history?[date_to_search] != nil {
                    while (self.all_history.count <= year_number) {
                        self.all_history.append(0)
                    }
                    if self.all_history[year_number] != nil {
                        self.all_history[year_number]! += houseDetails?.electricity_history?[date_to_search] ?? 0
                    } else {
                        self.all_history[year_number] = houseDetails?.electricity_history?[date_to_search] ?? 0
                    }
                }
            }
            
            self.graph_stack_view.subviews[0].removeFromSuperview()
            self.set_graph_to_view(view: "week", data: self.weekly_history)
        })
        
        
    }
    
    func reset_graph() {
        for subview in graph_stack_view.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func set_graph_to_view(view: String, data: Array<Double?>) {
        if data.count != 0 {
            type_of_graph = view
            let max = determine_maximum_value(data: data)
            if max != 0 {
                let graphView = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: graph_stack_view.frame.width, height: graph_stack_view.frame.height), dataSource: self)
                let linePlot = BarPlot(identifier: type_of_graph)
                linePlot.barColor = #colorLiteral(red: 0.5882352941, green: 0.737254902, blue: 0.368627451, alpha: 1)
                linePlot.barLineColor = #colorLiteral(red: 0.02745098039, green: 0.007843137255, blue: 0.1607843137, alpha: 1)
                let referenceLines = ReferenceLines()
                graphView.rangeMax = max
                graphView.addPlot(plot: linePlot)
                graphView.addReferenceLines(referenceLines: referenceLines)
                graph_stack_view.addSubview(graphView)
            } else {
                let no_data_view = UILabel(frame: CGRect(x: 0, y: 0, width: graph_stack_view.frame.width, height: graph_stack_view.frame.height))
                no_data_view.textAlignment = .center
                no_data_view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                no_data_view.text = "There is no data to display for this period"
                graph_stack_view.addSubview(no_data_view)
            }
        } else {
            let error_view = UILabel(frame: CGRect(x: 0, y: 0, width: graph_stack_view.frame.width, height: graph_stack_view.frame.height))
            error_view.textAlignment = .center
            error_view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            error_view.text = "Error loading data"
            graph_stack_view.addSubview(error_view)
        }
    }
    
    func determine_maximum_value(data: Array<Double?>) -> Double {
        var max = 0.0
        for data_point in data {
            if data_point != nil {
                if max < data_point! {
                    max = data_point!
                }
            }
        }
        return max
    }
    
}
