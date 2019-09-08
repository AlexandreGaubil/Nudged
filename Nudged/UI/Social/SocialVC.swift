//
//  SocialVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-08-19.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class SocialVC: UIViewController {
    
    @IBOutlet weak var scroll_view: UIScrollView!
    var tapped_view: (String, String, KindOfAchievements)?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
        
        create_new_achievement(title: "You care about the planet!", subtitle: "You reduced your energy consumption for 20 days straight! Share this with your friends", kind_of_achivement: .heart)
        create_new_achievement(title: "Saved a polar bear!", subtitle: "By reducing your monthly electric consumption 10 days in a row, you help save polar bears! Share this with your friends", kind_of_achivement: .polar_bear)
        create_new_achievement(title: "Help the Amazon!", subtitle: "You reduced your energy consumption for 5 days, showing that you care about the forests! Share this with your friends", kind_of_achivement: .tree)
        
    }
    
    private func create_new_achievement(title: String, subtitle: String, kind_of_achivement: KindOfAchievements) {
        let achivement_view = UIView(frame: CGRect(x: 0, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: 100))
        achivement_view.layer.cornerRadius = 15
        achivement_view.backgroundColor = UIColor(named: "blue-color") ?? UIColor.lightGray
        
        let badge_icon = UIImageView(frame: CGRect(x: 5, y: 5, width: 90, height: 90))
        //print(String(describing: kind_of_achivement) + ".png")
        
        badge_icon.image = UIImage(named: String(describing: kind_of_achivement) )//+ ".png")
        achivement_view.addSubview(badge_icon)
        
        let title_label = UILabel(frame: CGRect(x: 105, y: 10, width: UIScreen.main.bounds.width - 150, height: 30))
        title_label.text = title
        title_label.numberOfLines = 0
        title_label.font = UIFont.preferredFont(forTextStyle: .title2)
        title_label.frame = frame_for_label(label: title_label)
        title_label.textColor = .white
        
        print(title_label.frame.height + 10)
        let subtitle_label = UILabel(frame: CGRect(x: 105, y: title_label.frame.height + 10, width: UIScreen.main.bounds.width - 150, height: 70))
        subtitle_label.text = subtitle
        subtitle_label.numberOfLines = 0
        subtitle_label.textColor = .white
        subtitle_label.frame = frame_for_label(label: subtitle_label)
        subtitle_label.frame = CGRect(x: 105, y: title_label.frame.height + 10, width: UIScreen.main.bounds.width - 150, height: subtitle_label.frame.height)
        
//        let gesture_recogniser = UIGestureRecognizer(target: self, action: #selector(self.open_article(sender:)))
//        title_label.addGestureRecognizer(gesture_recogniser)
//        subtitle_label.addGestureRecognizer(gesture_recogniser)
//        achivement_view.addGestureRecognizer(gesture_recogniser)
//        title_label.isUserInteractionEnabled = true
//        subtitle_label.isUserInteractionEnabled = true
//
//        urls_to_open.append(url)
//        title_label.tag = urls_to_open.count - 1
//        subtitle_label.tag = urls_to_open.count - 1
        
        
        achivement_view.frame = CGRect(x: 0, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: title_label.frame.height + subtitle_label.frame.height + 20)
        
        if achivement_view.frame.height < 100 {
            achivement_view.frame = CGRect(x: 0, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: 100)
        }
        
        achivement_view.addSubview(title_label)
        achivement_view.addSubview(subtitle_label)
        scroll_view.contentSize.height += title_label.frame.height + subtitle_label.frame.height + 25
        scroll_view.addSubview(achivement_view)
    }
    
    @objc func share_achivement(sender: UIView) {
        
    }
}
