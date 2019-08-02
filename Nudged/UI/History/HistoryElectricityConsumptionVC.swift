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
        case "month": return "" //return (month_dates[pointIndex]).substring(toIndex: 2)
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
            all_dates.append(String((Int(year_date_formatter.string(from: Date.init())) ?? 2019) - i))
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
        case "01": year_dates = ["JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA", "AP", "MR", "FE"]
        case "02": year_dates = ["FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA", "AP", "MR"]
        case "03": year_dates = ["MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA", "AP"]
        case "04": year_dates = ["AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN", "MA"]
        case "05": year_dates = ["MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE", "JN"]
        case "06": year_dates = ["JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU", "SE"]
        case "07": year_dates = ["JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE", "AU"]
        case "08": year_dates = ["AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC", "SE"]
        case "09": year_dates = ["SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO", "OC"]
        case "10": year_dates = ["OC", "SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE", "NO"]
        case "11": year_dates = ["NO", "OC", "SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA", "DE"]
        case "12": year_dates = ["DE", "NO", "OC", "SE", "AU", "JL", "JN", "MA", "AP", "MR", "FE", "JA"]
        default: break
        }
        
        read_user_information(identifier: "0C97A1icrNmm5efNcPNT", completion: { houseDetails, error in
            
            //WEEK
            for week_date in self.week_dates {
                self.weekly_history.append(houseDetails?.electricity_history?[week_date])
            }
            //MONTH
            for month_date in self.month_dates {
                self.monthly_history.append(houseDetails?.electricity_history?[month_date])
            }
            //YEAR
            for i in 0...364 {
                var month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 0) - 1
                
                switch self.month_date_formatter.string(from: Date.init()) {
                case "01": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 1
                case "02": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 2
                case "03": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 3
                case "04": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 4
                case "05": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 5
                case "06": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 6
                case "07": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 7
                case "08": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 8
                case "09": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 9
                case "10": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 10
                case "11": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 11
                case "12": month_number = (Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))) ?? 9) - 12
                default: break
                }
                month_number = self.month_number_for_current_result(result: month_number)
                let date_to_search = date_formatter.string(from: Date.init() - TimeInterval(i * 3600 * 24))
                if !(Int(self.month_date_formatter.string(from: Date.init())) == Int(self.month_date_formatter.string(from: Date.init() - TimeInterval(i * 24 * 3600))) && i > 60) {
                    self.yearly_history[month_number] += Double(houseDetails?.electricity_history?[date_to_search] ?? 0) //+ self.yearly_history[month_number]
                }
            }
            //ALL
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
            
            self.reset_graph()
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
                linePlot.barColor = UIColor(named: "green-color") ?? UIColor.black
                linePlot.barLineColor = UIColor(named: "dark-blue-color") ?? UIColor.black
                let referenceLines = ReferenceLines()
                graphView.rangeMax = max
                graphView.rightmostPointPadding = 10
                graphView.shouldAnimateOnStartup = false
                if type_of_graph == "month" {
                    graphView.leftmostPointPadding = 30
                    graphView.dataPointSpacing = 11
                    linePlot.barWidth = 8
                }
                if type_of_graph == "year" {
                    graphView.dataPointSpacing = 27
                    linePlot.barWidth = 20
                }
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
}
