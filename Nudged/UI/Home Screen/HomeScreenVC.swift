//
//  HomeScreenVC.swift
//  Nudged
//
//  Created by Alexandre Gaubil on 2019-07-21.
//  Copyright © 2019 Alexandre Gaubil. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if UserDefaults.standard.bool(forKey: UserDefaultsKeys.logged_in) != true {
                let bundle = Bundle.main
                let storyboard = UIStoryboard(name: "Main", bundle: bundle)
                var newViewController: UIViewController!
                newViewController = storyboard.instantiateViewController(withIdentifier: "StartupView")
                self.present(newViewController, animated: true, completion: nil)
            }
        }
        
        
        let comparisonView = UIView()
        comparisonView.frame.size.height = 300
        comparisonView.frame.size.width = 300
        comparisonView.center = CGPoint(x: 200, y: UIScreen.main.bounds.width / 2)
        comparisonView.layer.cornerRadius = comparisonView.frame.size.width / 2
        comparisonView.layer.masksToBounds = true
        comparisonView.layer.borderWidth = 5
        comparisonView.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        let percentileLabel = UILabel(frame: CGRect(x: 100, y: 50, width: 100, height: 50))
        percentileLabel.text = String(describing: compare_house_consumption_to_houses_with_same_postal_code()) + " %"
        percentileLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        percentileLabel.textAlignment = .center
        comparisonView.addSubview(percentileLabel)
        
        stackView.addSubview(comparisonView)
    }


}

