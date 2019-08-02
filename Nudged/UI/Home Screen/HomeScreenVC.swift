//
//  HomeScreenVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    @IBOutlet weak var scroll_view: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Present first time screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if UserDefaults.standard.bool(forKey: UserDefaultsKeys.logged_in) != true {
                let bundle = Bundle.main
                let storyboard = UIStoryboard(name: "Main", bundle: bundle)
                var newViewController: UIViewController!
                newViewController = storyboard.instantiateViewController(withIdentifier: "StartupView")
                self.present(newViewController, animated: true, completion: nil)
            }
        }
        
        //MARK: Comparison wheel
        let comparison_view = UIView()
        comparison_view.frame.size.height = 300
        comparison_view.frame.size.width = 300
        comparison_view.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 200)
        comparison_view.layer.cornerRadius = comparison_view.frame.size.width / 2
        comparison_view.layer.masksToBounds = true
        comparison_view.layer.borderWidth = 5
        comparison_view.layer.borderColor = UIColor(named: "green-color")?.cgColor
        
        let percentile_label = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
        percentile_label.text = String(describing: compare_house_consumption_to_houses_with_same_postal_code()) + " %"
        percentile_label.font = UIFont.preferredFont(forTextStyle: .title1)
        percentile_label.textAlignment = .center
        comparison_view.addSubview(percentile_label)
        
        let percentile_info_label = UILabel(frame: CGRect(x: 20, y: 100, width: 260, height: 40))
        percentile_info_label.text = "of people have a worst electric consumption than you"
        percentile_info_label.font = UIFont.preferredFont(forTextStyle: .caption1)
        percentile_info_label.textAlignment = .center
        percentile_info_label.numberOfLines = 0
        comparison_view.addSubview(percentile_info_label)
        
        let amount_saved_label = UILabel(frame: CGRect(x: 100, y: 140, width: 100, height: 50))
        amount_saved_label.text = String(describing: amount_saved()) + " $"
        amount_saved_label.font = UIFont.preferredFont(forTextStyle: .title1)
        amount_saved_label.textAlignment = .center
        comparison_view.addSubview(amount_saved_label)
        
        let amount_saved_info_label = UILabel(frame: CGRect(x: 20, y: 190, width: 260, height: 40))
        amount_saved_info_label.text = "amount you can save this month on electric bills"
        amount_saved_info_label.font = UIFont.preferredFont(forTextStyle: .caption1)
        amount_saved_info_label.textAlignment = .center
        amount_saved_info_label.numberOfLines = 0
        comparison_view.addSubview(amount_saved_info_label)
        
        view.addSubview(comparison_view)
        
        //MARK: Tips section
        //scroll_view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        let demarcation_view = UIView(frame: CGRect(x: 50, y: 380, width: UIScreen.main.bounds.width - 100, height: 1))
        demarcation_view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.addSubview(demarcation_view)
        
        let tip_label_title = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - 50) / 2, y: 10, width: 100, height: 30))
        tip_label_title.text = "Tips"
        tip_label_title.font = UIFont.preferredFont(forTextStyle: .title1)
        scroll_view.addSubview(tip_label_title)
        scroll_view.contentSize.height = 50
        
        scroll_view.addSubview(create_new_tip(title: "Unplug unused appliances", subtitle: "Unused appliances, even turned off, consume power while plugged in.", url: "www.apple.com"))
        scroll_view.addSubview(create_new_tip(title: "Unplug two appliances", subtitle: "Unused appliances, even turned off, consume power while plugged in.", url: "www.apple.com"))
        scroll_view.addSubview(create_new_tip(title: " 😅", subtitle: "Unused appliances, even turned off, consume power while plugged in.", url: "www.apple.com"))
        scroll_view.addSubview(create_new_tip(title: "Unplug unused appliances", subtitle: "Unused appliances, even turned off, consume power while plugged in.", url: "www.apple.com"))
        scroll_view.addSubview(create_new_tip(title: "Unplug two appliances", subtitle: "Unused appliances, even turned off, consume power while plugged in.", url: "www.apple.com"))
        scroll_view.addSubview(create_new_tip(title: " 😅", subtitle: "Unused appliances, even turned off, consume power while plugged in.", url: "www.apple.com"))
        
        scroll_view.contentSize.height += 10
    }
    
    func create_new_tip(title: String, subtitle: String, url: String) -> UIView {
        let tip_view = UIView(frame: CGRect(x: 20, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: 100))
        scroll_view.contentSize.height += 106
        tip_view.backgroundColor = #colorLiteral(red: 0.93152982, green: 0.93152982, blue: 0.93152982, alpha: 1)
        
        let title_label = UILabel(frame: CGRect(x: 5, y: 0, width: UIScreen.main.bounds.width - 50, height: 30))
        title_label.text = title
        tip_view.addSubview(title_label)
        title_label.font = UIFont.preferredFont(forTextStyle: .title2)
        
        let subtitle_label = UILabel(frame: CGRect(x: 5, y: 30, width: UIScreen.main.bounds.width - 50, height: 70))
        subtitle_label.text = subtitle
        tip_view.addSubview(subtitle_label)
        subtitle_label.numberOfLines = 0
        
        return tip_view
    }
}
