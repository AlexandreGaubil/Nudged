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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        create_new_achievement(title: "Saved a polar bear!", subtitle: "By reducing your monthly electric consumption of 124kWh, you have saved a polar bear! Share this with your friends", kind_of_achivement: .polar_bears)
    }
    
    private func create_new_achievement(title: String, subtitle: String, kind_of_achivement: KindOfAchievements) {
        let achivement_view = UIView(frame: CGRect(x: 0, y: scroll_view.contentSize.height + 6, width: UIScreen.main.bounds.width - 40, height: 100))
        scroll_view.contentSize.height += 106
        achivement_view.backgroundColor = #colorLiteral(red: 0.93152982, green: 0.93152982, blue: 0.93152982, alpha: 1)
        
        let badge_icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        print(String(describing: kind_of_achivement) + ".png")
        badge_icon.image = UIImage(named: String(describing: kind_of_achivement) + ".png")
        achivement_view.addSubview(badge_icon)
        
        let title_label = UILabel(frame: CGRect(x: 105, y: 0, width: UIScreen.main.bounds.width - 150, height: 30))
        title_label.text = title
        title_label.font = UIFont.preferredFont(forTextStyle: .title2)
        achivement_view.addSubview(title_label)
        
        let subtitle_label = UILabel(frame: CGRect(x: 105, y: 30, width: UIScreen.main.bounds.width - 150, height: 70))
        subtitle_label.text = subtitle
        subtitle_label.numberOfLines = 0
        achivement_view.addSubview(subtitle_label)
        
        let gesture_recogniser = UIGestureRecognizer(target: nil, action: #selector(share_achivement(sender:)))
        achivement_view.addGestureRecognizer(gesture_recogniser)
        scroll_view.addSubview(achivement_view)
    }
    
    @objc func share_achivement(sender: UIView) {
        
    }
}
