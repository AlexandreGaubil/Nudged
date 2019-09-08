//
//  HomeScreenVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

let colorTop =  #colorLiteral(red: 0.08235294118, green: 0.4901960784, blue: 0.4941176471, alpha: 1).cgColor
let colorBottom = #colorLiteral(red: 0.02745098039, green: 0.1490196078, blue: 0.1568627451, alpha: 1).cgColor

class HomeScreenVC: UIViewController {

    @IBOutlet weak var scroll_view: UIScrollView!
    var urls_to_open: [String] = []
    var current_tag = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Now")
        print(normal_electric_consumption(house_type: .separate_house, house_surface: 300, number_of_house_inhabitants: 5, normal_house_in_neighborhood: normal_house_one))
        print(normal_electric_consumption(house_type: .apartment, house_surface: 70, number_of_house_inhabitants: 2, normal_house_in_neighborhood: normal_house_one))
        print("end")
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
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
        percentile_label.font = UIFont.preferredFont(forTextStyle: .title1)
        percentile_label.textAlignment = .center
        percentile_label.textColor = .white
        comparison_view.addSubview(percentile_label)
        
        let percentile_info_label = UILabel(frame: CGRect(x: 20, y: 100, width: 260, height: 40))
        percentile_info_label.font = UIFont.preferredFont(forTextStyle: .caption1)
        percentile_info_label.textAlignment = .center
        percentile_info_label.numberOfLines = 0
        percentile_info_label.textColor = .white
        
        let amount_saved_label = UILabel(frame: CGRect(x: 50, y: 140, width: 200, height: 50))
        amount_saved_label.font = UIFont.preferredFont(forTextStyle: .title1)
        amount_saved_label.textAlignment = .center
        amount_saved_label.textColor = .white
        
        let amount_saved_info_label = UILabel(frame: CGRect(x: 20, y: 190, width: 260, height: 40))
        amount_saved_info_label.font = UIFont.preferredFont(forTextStyle: .caption1)
        amount_saved_info_label.textAlignment = .center
        amount_saved_info_label.numberOfLines = 0
        amount_saved_info_label.textColor = .white
        
        view.addSubview(comparison_view)
        
        read_user_information(identifier: "0C97A1icrNmm5efNcPNT", completion: { houseDetails, error in
            user_house = UserHouse(number_of_inhabitants: houseDetails?.number_of_house_inhabitants ?? 0, size_of_house: houseDetails?.house_size ?? 0.0 , kind_of_house: houseDetails?.kind_of_house ?? HouseType.apartment)
            
            let result = compare_house_consumption_to_houses_with_same_postal_code()
            switch result.1 {
            case .better_than_normal:
                comparison_view.layer.borderColor = UIColor( #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)).cgColor
                percentile_label.text = String(result.0) + "%"
                percentile_info_label.text = "You use " + String(result.0) + "% less electricity than your neighbors"
            case .worse_than_normal:
                if result.0 < 50 {
                    comparison_view.layer.borderColor = UIColor( #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).cgColor //UIColor(named: "orange-color")?.cgColor
                } else {
                    comparison_view.layer.borderColor = UIColor( #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)).cgColor //UIColor(named: "red-color")?.cgColor
                }
                percentile_label.text = String(result.0) + "%"
                percentile_info_label.text = "You use " + String(result.0) + "% more electricity than your neighbors"
            case .equal_to_normal:
                comparison_view.layer.borderColor = UIColor( #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).cgColor //UIColor(named: "yellow-color")?.cgColor
                percentile_label.text = String(result.0) + "%"
                percentile_info_label.text = "You use the same amount of electricity than your neighbors"
            }
            
            let result_amount_saved = amount_saved()
            switch result_amount_saved.1 {
            case .better_than_normal:
                amount_saved_label.text = String(result_amount_saved.0) + " $"
                amount_saved_info_label.text = "You can save " + String(result_amount_saved.0) + " $ these next 30 days on electricity bills"
            case .worse_than_normal:
                amount_saved_label.text = String(result_amount_saved.0) + "$"
                amount_saved_info_label.text = "You have saved " + String(result_amount_saved.0) + "$ these past 30 days on electricity bills"
            case .equal_to_normal: break
            }
            
            comparison_view.addSubview(amount_saved_label)
            comparison_view.addSubview(percentile_label)
            comparison_view.addSubview(percentile_info_label)
            comparison_view.addSubview(amount_saved_info_label)
        })
        
        //MARK: Tips section
        let demarcation_view = UIView(frame: CGRect(x: 50, y: 380, width: UIScreen.main.bounds.width - 100, height: 1))
        demarcation_view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.addSubview(demarcation_view)
        
        let tip_label_title = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - 50) / 2, y: 10, width: 100, height: 30))
        tip_label_title.text = "Tips"
        tip_label_title.font = UIFont.preferredFont(forTextStyle: .title1)
        tip_label_title.textColor = .white
        scroll_view.addSubview(tip_label_title)
        scroll_view.contentSize.height = 50
        
        create_new_tip(title: "10 Ways to Reduce Your Home’s Power Use", subtitle: "These 10 great tips will help you to reduce your household's electricity consumption!", url: "www.angieslist.com/articles/10-ways-reduce-your-home-s-power-use.htm")
        
        create_new_tip(title: "What Uses the Most Energy in Your Home?", subtitle: "Learn how to control the most power-hungry devices in your home, and drastically reduce your consumption!", url: "www.visualcapitalist.com/what-uses-the-most-energy-home/")
        
        create_new_tip(title: "What Are the Effects of Overusing Energy?", subtitle: "The effects of living beyond our means", url: "homeguides.sfgate.com/effects-overusing-energy-78753.html")
        
        create_new_tip(title: "The Big Thaw", subtitle: "Ice caps melting at an alarming rate!", url: "www.nationalgeographic.com/environment/global-warming/big-thaw/")
        
//        create_new_tip(title: "", subtitle: "", url: "www.apple.com")
        
//        create_new_tip(title: "", subtitle: "", url: "www.apple.com")
        
        scroll_view.contentSize.height += 10
    }
    
    private func create_new_tip(title: String, subtitle: String, url: String) {
        let tip_view = UIView(frame: CGRect(x: 20, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: 100))
        tip_view.backgroundColor = UIColor(named: "blue-color") ?? UIColor.lightGray
        tip_view.layer.cornerRadius = 15
        
        let title_label = UILabel(frame: CGRect(x: 5, y: 10, width: UIScreen.main.bounds.width - 50, height: 30))
        title_label.text = title
        title_label.numberOfLines = 0
        title_label.font = UIFont.preferredFont(forTextStyle: .title2)
        title_label.frame = frame_for_label(label: title_label)
        title_label.textColor = .white
        
        print(title_label.frame.height + 10)
        let subtitle_label = UILabel(frame: CGRect(x: 5, y: title_label.frame.height + 10, width: UIScreen.main.bounds.width - 50, height: 70))
        subtitle_label.text = subtitle
        subtitle_label.numberOfLines = 0
        subtitle_label.textColor = .white
        subtitle_label.frame = frame_for_label(label: subtitle_label)
        subtitle_label.frame = CGRect(x: 5, y: title_label.frame.height + 10, width: UIScreen.main.bounds.width - 50, height: subtitle_label.frame.height)
        
        let gesture_recogniser = UIGestureRecognizer(target: self, action: #selector(self.open_article(sender:)))
        title_label.addGestureRecognizer(gesture_recogniser)
        subtitle_label.addGestureRecognizer(gesture_recogniser)
        tip_view.addGestureRecognizer(gesture_recogniser)
        title_label.isUserInteractionEnabled = true
        subtitle_label.isUserInteractionEnabled = true
        
        urls_to_open.append(url)
        title_label.tag = urls_to_open.count - 1
        subtitle_label.tag = urls_to_open.count - 1
        
        tip_view.frame = CGRect(x: 20, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: title_label.frame.height + subtitle_label.frame.height + 20)
        tip_view.addSubview(title_label)
        tip_view.addSubview(subtitle_label)
        scroll_view.contentSize.height += title_label.frame.height + subtitle_label.frame.height + 25
        scroll_view.addSubview(tip_view)
    }
    
    @objc func open_article(sender: UIView) {
        print("Sender tag: \(sender.tag): \(urls_to_open[sender.tag])")
        if let url = URL(string: urls_to_open[sender.tag]) {
            UIApplication.shared.open(url)
        }
    }
}
